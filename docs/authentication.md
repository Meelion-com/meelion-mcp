# Autenticação E Acesso Premium

O Meelion MCP aceita chamadas sem autenticação. Esse modo público foi criado para permitir que assistentes de IA consultem informações gerais de mercado e dados resumidos de investimentos.

## Acesso Público

Sem API key, o MCP pode retornar:

- Indicadores financeiros formatados.
- Cotações atuais em formato estruturado.
- Rankings resumidos de investimentos.
- Dados básicos de ativos, como tipo, emissor, distribuidor, indexador, vencimento e investimento mínimo.

Nesse modo, alguns campos são omitidos para proteger dados premium e evitar uso indevido.

## Acesso Premium

O acesso premium estará disponível em breve para assinantes do **Meelion Pro**.

Quando a funcionalidade for liberada, usuários premium poderão gerar uma API key e enviar:

```http
Authorization: Bearer meelion_mcp_...
```

## O Que O Premium Deve Liberar

Dependendo do plano e da disponibilidade da funcionalidade, o acesso premium poderá incluir:

- Taxas líquidas.
- Valores líquidos projetados.
- Ranking completo de ativos.
- Bloco `top_three_assets`.
- Payloads brutos usados internamente pela Meelion.
- Links e metadados adicionais quando disponíveis.

## Modos De Resposta

| Situação | Resultado |
| --- | --- |
| Sem API key | Acesso público. |
| API key inválida | `401 Unauthorized`. |
| API key válida sem premium | Acesso autenticado limitado. |
| API key válida com Meelion Pro | Acesso premium completo, quando disponível. |

## Boas Práticas

- Nunca coloque sua API key em query string.
- Não publique sua API key em repositórios, prints ou logs.
- Use variáveis de ambiente para armazenar a chave.
- Revogue chaves antigas ou comprometidas.
- Use uma chave separada para cada cliente, agente ou automação.

