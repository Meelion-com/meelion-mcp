# Autenticação

O Meelion MCP aceita chamadas sem autenticação. Nesse modo, a IA recebe apenas dados públicos.

Para desbloquear dados premium, envie uma API key no header `Authorization`.

```http
Authorization: Bearer meelion_mcp_...
```

## Modos De Acesso

| Situação | Resultado |
| --- | --- |
| Sem Bearer | Acesso público. |
| Bearer inválido | `401 Unauthorized`. |
| Bearer válido sem plano premium | Acesso autenticado limitado. |
| Bearer válido com premium | Acesso completo. |

## Dados Premium

Quando o token pertence a um usuário com acesso premium, o MCP pode retornar:

- Taxas líquidas.
- Valores líquidos projetados.
- Dados brutos da origem interna.
- Ranking completo de ativos.
- Bloco `top_three_assets`.

## Segurança

Boas práticas:

- Não coloque a API key em query string.
- Não publique sua API key em repositórios.
- Revogue chaves que não estiverem em uso.
- Use uma chave por cliente ou automação.

