# README
## Funcionalidades
- Fazer login;
- Fazer logout;
- Reportar bug;
- Listar bugs reportados;
- Filtrar bugs reportados;
- Atualizar o andamento da correção de um bug.

## Backlog futuro
- Multitenancy por schema ou por banco de dados;
- Integrar com o gitlab (criar issue e atualizar status);
- Integrar com o slack (mandar mensagem em algum canal);

## Entidades
### User
#### Atributos
- id - int;
- uid - string;
- username - string;
- encrypted_password - string;
- name - string;
- tokens - string[];
- kind - enum
