Script para criação de um Ansible Server
===========================================

# Descrição

Esse script foi criado para automatizar a preparação de servidores Ansible em distribuições GNU/Linux como Debian, Ubuntu, Mint e CentOS.
No momento está pronto apenas para CentOS.

Requisitos
----------

 - [CentOS] CentOS 8

Outras distribuições ainda em desenvolvimento.

Instalação
----------

 - Logue no host e execute o comando abaixo como root.


```yum install -y git && cd /home && git clone https://github.com/renatotecchio/ansible_server.git && ansible_server/main.sh```

Configuração
------------

O script criará o ambiente em um ambiente de usuário diferente de root, isso é recomendável em ambiente de produção compartilhado e é uma boa prática.
O nome de usuário poderá ser informado de 3 maneiras:
1- Passar o nome do usuário logo após o comando main. O mais recomendável;
2- Configurar a variável XXXX dentro do arquivo de configuração na variável YYYYYYYY;
3- Não informar e aguardar o script solicitar o nome de usuário no prompt de comando.


Dúvidas?
----------

Caso tenha dúvidas ou precise de suporte, envie um email para mim: [renatotecchio@gmail.com].
Obs.: Idéias ou dicas para melhorar o código são muito bem vindas.

Changelog
---------

1.0.0
 - Refatoração do código base.

Contribuições
-------------

Achou e corrigiu um bug ou tem alguma feature em mente e deseja contribuir?

* Faça um fork
* Adicione sua feature ou correção de bug (git checkout -b my-new-feature)
* Commit suas mudanças (git commit -am 'Added some feature')
* Rode um push para o branch (git push origin my-new-feature)
* Envie um Pull Request
* Obs.: Adicione exemplos para sua nova feature. Se seu Pull Request for relacionado a uma versão específica, o Pull Request não deve ser enviado para o branch master e sim para o branch correspondente a versão.
* Obs2: Não serão aceitos PR's na branch master. Utilizar a branch de desenvolvimento.

  [CentOS]: https://www.centos.org/
  [renatotecchio@gmail.com]: renatotecchio@gmail.com
