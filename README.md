# Rex Canais

Painel web para gerenciar clientes, mensalidades e cobranças da Rex Canais.

## Recursos

- Cadastro, edição e exclusão de clientes.
- Busca por nome ou telefone e filtro por vencimento.
- Resumo de clientes e receita mensal.
- Link de cobrança pelo WhatsApp.
- Exportação CSV e backup/restauração JSON.
- Login por e-mail e senha com Supabase Auth.
- Dados persistidos no Supabase e isolados por usuário com Row Level Security (RLS).

## Arquivos

- `index.html`: aplicação web em um único arquivo.
- `supabase-setup.sql`: cria a tabela `public.clientes`, ativa RLS e configura políticas para cada usuário acessar somente seus próprios registros.

## Configuração do Supabase

1. Crie um projeto no [Supabase](https://supabase.com/).
2. Abra **SQL Editor**, cole o conteúdo de `supabase-setup.sql` e execute.
3. Em **Authentication → URL Configuration**, configure o endereço do site publicado como **Site URL** e adicione-o às **Redirect URLs**.
4. Em **Authentication → Email**, configure a confirmação de e-mail. O SMTP padrão tem limite baixo; para uso frequente, configure um provedor SMTP próprio.
5. A URL do projeto e a chave pública (*publishable key*) estão configuradas no JavaScript de `index.html`. Chaves `service_role` ou senhas do banco nunca devem ser colocadas no navegador nem no repositório.

## Executar e publicar

O site é estático e não requer build:

1. Abra `index.html` localmente para desenvolvimento ou publique o arquivo em um serviço de hospedagem estática, como o Netlify.
2. Após alterar o código, publique novamente a versão atualizada de `index.html`.
3. O endereço de confirmação do cadastro está definido pela constante `SITE_URL` em `index.html`; ajuste-a se o domínio do site mudar e publique novamente.

## Importar clientes que já estavam no navegador

Entre na conta Supabase no site e use **Backup local** para exportar os dados antigos. Depois, use **Restaurar backup** ou **Importar deste navegador** para copiá-los para a conta. A importação do backup adiciona os clientes existentes, sem apagar os registros que já estão no banco.

## Dados e privacidade

Os cadastros contêm informações de clientes. Mantenha o repositório privado se incluir dados operacionais e nunca adicione backups JSON/CSV ao GitHub. O arquivo `rex-backup-clientes.json` é dado local e deve permanecer fora do repositório. A chave pública Supabase é usada pelo navegador; a proteção dos registros depende das políticas RLS do banco.
