module suisnap::suisnap {
    use std::vector;
    use sui::event;
    use sui::object::{Self, ID, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    friend suisnap::tests;

    const E_NOT_OWNER: u64 = 1;
    const E_LINK_CAP_MISMATCH: u64 = 2;
    const E_INVALID_URL: u64 = 3;
    const E_INVALID_SHORT_CODE: u64 = 4;
    const E_URL_TOO_LONG: u64 = 5;
    const E_SHORT_CODE_TOO_LONG: u64 = 6;

    const MAX_URL_LENGTH: u64 = 2048;
    const MAX_SHORT_CODE_LENGTH: u64 = 50;
    const MIN_SHORT_CODE_LENGTH: u64 = 1;

    struct Link has key {
        id: UID,
        owner: address,
        original_url: vector<u8>,
        short_code: vector<u8>,
    }

    struct EditCap has key {
        id: UID,
        link_id: ID,
        owner: address,
    }

    // Funções públicas para acessar campos (para testes)
    public fun owner(link: &Link): address {
        link.owner
    }

    public fun link_id(cap: &EditCap): ID {
        cap.link_id
    }

    struct LinkCreated has copy, drop {
        link_id: ID,
        owner: address,
        short_code: vector<u8>,
    }

    struct LinkUpdated has copy, drop {
        link_id: ID,
        owner: address,
        short_code: vector<u8>,
    }

    struct LinkDeleted has copy, drop {
        link_id: ID,
        owner: address,
    }

    /// Valida se a URL tem formato básico válido (começa com http:// ou https://)
    fun validate_url(url: &vector<u8>): bool {
        let len = vector::length(url);
        if (len > MAX_URL_LENGTH || len == 0) {
            return false
        };
        // Verifica se começa com http:// (7 caracteres: h-t-t-p-:-/-/)
        if (len >= 7) {
            let http0 = *vector::borrow(url, 0); // h = 104
            let http1 = *vector::borrow(url, 1); // t = 116
            let http2 = *vector::borrow(url, 2); // t = 116
            let http3 = *vector::borrow(url, 3); // p = 112
            let http4 = *vector::borrow(url, 4); // : = 58
            let http5 = *vector::borrow(url, 5); // / = 47
            let http6 = *vector::borrow(url, 6); // / = 47
            if (http0 == 104 && http1 == 116 && http2 == 116 && http3 == 112 && http4 == 58 && http5 == 47 && http6 == 47) {
                return true
            };
        };
        // Verifica se começa com https:// (8 caracteres: h-t-t-p-s-:-/-/)
        if (len >= 8) {
            let https0 = *vector::borrow(url, 0); // h = 104
            let https1 = *vector::borrow(url, 1); // t = 116
            let https2 = *vector::borrow(url, 2); // t = 116
            let https3 = *vector::borrow(url, 3); // p = 112
            let https4 = *vector::borrow(url, 4); // s = 115
            let https5 = *vector::borrow(url, 5); // : = 58
            let https6 = *vector::borrow(url, 6); // / = 47
            let https7 = *vector::borrow(url, 7); // / = 47
            if (https0 == 104 && https1 == 116 && https2 == 116 && https3 == 112 && https4 == 115 && https5 == 58 && https6 == 47 && https7 == 47) {
                return true
            };
        };
        false
    }

    /// Valida o código curto (tamanho e caracteres alfanuméricos)
    fun validate_short_code(code: &vector<u8>): bool {
        let len = vector::length(code);
        if (len < MIN_SHORT_CODE_LENGTH || len > MAX_SHORT_CODE_LENGTH) {
            return false
        };
        // Verifica se todos os caracteres são alfanuméricos ou hífen/underscore
        let i = 0;
        while (i < len) {
            let char = *vector::borrow(code, i);
            // 0-9, A-Z, a-z, -, _
            if (!((char >= 48 && char <= 57) || // 0-9
                  (char >= 65 && char <= 90) || // A-Z
                  (char >= 97 && char <= 122) || // a-z
                  char == 45 || // -
                  char == 95)) { // _
                return false
            };
            i = i + 1;
        };
        true
    }

    /// Helper para clonar um vector
    fun clone_vector(v: &vector<u8>): vector<u8> {
        let len = vector::length(v);
        let result = vector::empty<u8>();
        let i = 0;
        while (i < len) {
            vector::push_back(&mut result, *vector::borrow(v, i));
            i = i + 1;
        };
        result
    }

    /// Retorna a URL original do link (função de leitura pública)
    public fun get_url(link: &Link): vector<u8> {
        clone_vector(&link.original_url)
    }

    /// Retorna o código curto do link
    public fun get_short_code(link: &Link): vector<u8> {
        clone_vector(&link.short_code)
    }

    /// Retorna o owner do link
    public fun get_owner(link: &Link): address {
        link.owner
    }

    /// Cria um link e uma capability de edição e transfere ambos para o remetente.
    public entry fun create_link(original_url: vector<u8>, short_code: vector<u8>, ctx: &mut TxContext) {
        // Validações
        if (!validate_url(&original_url)) {
            abort E_INVALID_URL
        };
        if (!validate_short_code(&short_code)) {
            abort E_INVALID_SHORT_CODE
        };
        
        let sender = tx_context::sender(ctx);
        let (link, cap) = create_link_internal(sender, original_url, short_code, ctx);
        let link_id = object::id(&link);
        let short_copy = clone_vector(&link.short_code);
        event::emit(LinkCreated { link_id, owner: sender, short_code: short_copy });
        transfer::transfer(link, sender);
        transfer::transfer(cap, sender);
    }

    /// Atualiza o link se o actor for o dono e a capability corresponder.
    public entry fun update_link(link: &mut Link, cap: &EditCap, new_url: vector<u8>, new_short_code: vector<u8>, ctx: &TxContext) {
        // Validações
        if (!validate_url(&new_url)) {
            abort E_INVALID_URL
        };
        if (!validate_short_code(&new_short_code)) {
            abort E_INVALID_SHORT_CODE
        };
        
        let actor = tx_context::sender(ctx);
        update_link_internal(link, cap, actor, new_url, new_short_code);
    }

    /// Exclui o link e a capability após checar autorização.
    public entry fun delete_link(link: Link, cap: EditCap, ctx: &TxContext) {
        let actor = tx_context::sender(ctx);
        delete_link_internal(link, cap, actor);
    }

    // ---------- Helpers expostos a testes ----------
    public(friend) fun create_link_internal(owner: address, original_url: vector<u8>, short_code: vector<u8>, ctx: &mut TxContext): (Link, EditCap) {
        let link = Link { id: object::new(ctx), owner, original_url, short_code };
        let cap = EditCap { id: object::new(ctx), link_id: object::id(&link), owner };
        (link, cap)
    }

    public(friend) fun update_link_internal(link: &mut Link, cap: &EditCap, actor: address, new_url: vector<u8>, new_short_code: vector<u8>) {
        enforce_access(link, cap, actor);
        link.original_url = new_url;
        link.short_code = new_short_code;
        event::emit(LinkUpdated {
            link_id: object::id(link),
            owner: actor,
            short_code: clone_vector(&link.short_code),
        });
    }

    public(friend) fun delete_link_internal(link: Link, cap: EditCap, actor: address) {
        enforce_access(&link, &cap, actor);
        let Link { id, owner: _, original_url: _, short_code: _ } = link;
        let EditCap { id: cap_id, link_id, owner: _ } = cap;
        event::emit(LinkDeleted { link_id, owner: actor });
        object::delete(id);
        object::delete(cap_id);
    }

    // ---------- Regras de autorização ----------
    fun enforce_access(link: &Link, cap: &EditCap, actor: address) {
        if (cap.owner != actor) {
            abort E_NOT_OWNER
        };
        if (cap.link_id != object::id(link)) {
            abort E_LINK_CAP_MISMATCH
        };
    }
}
