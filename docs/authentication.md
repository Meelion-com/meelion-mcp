# Acesso Ao MCP

O Meelion MCP aceita chamadas sem autenticação. Esse modo foi criado para permitir que assistentes de IA consultem informações de mercado e dados estruturados de investimentos com pouca fricção.

## Como Acessar

Envie requisições JSON-RPC para:

```text
POST https://mcp.meelion.com/
Content-Type: application/json
```

Não é necessário enviar credenciais nesta fase.

## Dados Disponíveis

O MCP pode retornar:

- Indicadores financeiros formatados.
- Cotações atuais em formato estruturado.
- Rankings de investimentos.
- Dados de ativos, como tipo, emissor, distribuidor, indexador, vencimento e investimento mínimo.
- Campos de rentabilidade e projeção quando disponíveis nos dados da Meelion.
- Blocos estruturados como `top_three_assets` em ferramentas que suportam destaque de resultados.

## Modos De Resposta

| Situação | Resultado |
| --- | --- |
| Sem autenticação | Acesso permitido. |
| Credenciais ausentes | Acesso permitido. |

## Boas Práticas

- Use sempre `POST` com `Content-Type: application/json`.
- Trate as respostas como dados informativos, não como recomendação de investimento.
- Evite enviar informações pessoais ou sensíveis nos argumentos das tools.
- Mantenha cache do lado do cliente quando fizer sentido para reduzir chamadas repetidas.
