NOTA: COM A INCLUSAO DO SECRETS PARA ACESSO AO MYSQL DENTRO DO ARQUIVO DEPLOYMENT.YML, NAO É POSSIVEL MAIS ENTRAR DENTRO DO POD MYSQL, PARA VERIFICAÇAO DAS MENSAGENS SALVAS NO BANCO DE DADOS!!!


# Construção da arquitetura: aplicação e banco de dados

1 - Arquitetura proposta para o projeto:
    - Githube Actions para realizar o build e push das imagens docker automaticamente a cada git push executado 
    - Minikube para geração do cluster kubernetes
    - Powershell para controle do kubernetes (kubectl) (Execuçao dos arquivos locais, os mesmos carregados no repositório remoto do github)

2 - No powershell, baixe este projeto usando git:
    git clone https://github.com/carlosfalcone/k8s-projeto2-cicd.git

3 - Delete a pasta .git dentro deste projeto

4 - Crie um repositorio novo no github (publico e sem readme.md)

5 - Abra o powershell e execute o minikube:
    minikube start >>
    minikube status

6 - Verifique se o cluster foi carregado:
    kubectl get nodes

7 - Faça o deployment do load-balancer.yml e do secrets.yml atraves do script s1-load... (arquivo dentro da pasta do projeto)
    .\s1-loadbalancer-and-secrets.bat

8 - Verifique se o serviço foi carregado:
    kubectl get services (deve aparecer o app1-service e o my-secret)

9 - Exclua o arquivo secrets.yml e copie a url de acesso ao pod, extraida na execuçao do script s1-load...:

10 - Copie e salve esta url no arquivo na linha exemplificada abaixo, no arquivo js.js:
    url: "http://192.168.59.101:30203/incluir.php",

11 - Suba os arquivos locais para o diretorio remoto no github. Observe que o arquivo js.js já será carregado com a alterçao na url acima.
    git init >>
    git add . >>
    git commit -m "insira-aqui-seu-texto" >>
    git branch -M main >>
    git remote add origin copie-e-cole-o-caminho-para-clone-https >>
    git push -u origin main

12 - Verifique a execução do Github Actions e se as imagens foram carregadas no docker hub

13 - Volte para o Powershell e execute o script s2-load-kubernetes.bat (script para windows). Ele irá fazer o deployment das imagens do docker carregadas anteriormente no docker hub, para dentro dos pods do kubernetes:
    .\s2-load-kubernetes.bat

14 - Verifique se os pods foram carregados:
    .\s3-informacoes-kubernetes.bat

15 - Entre com a url no browser e verifique se o frontend foi carregado:
    http://192.168.59.101:30203

16 - Entre com os dados no frontend e clique no botao enviar. Se tudo ocorrer bem, você receberá uma mensagem de que os dados foram salvos.

17 - Para verificar o seu banco de dados, entre no pod do mysql e verifique os dados usando o comando mysql:
    kubectl exec --stdin --tty  [nome-do-pod-mysql] -- /bin/bash >>
    mysql -u root -p >>
    Entre com a senha >>
    Entre com os comandos SQL (use meubanco;) (show tables;) (etc...)


## Utilização recorrente da arquitetura

### Modo fácil

- execute cada um dos scritps .bat de acordo com a necessidade, após carregar a estrutura dos arquivos

### Modo manual

1 - Faça a atualizaçao do projeto, usando o vscode: app (frontend: index, css ou js / backend: *.php) ou bancodedados (sql) e depois altere os campos dentro do arquivo s5-update...:
    SET TAG_BACKFRONT=1.1 (atualize o numero da versão)
    SET TAG_DATABASE=1.1 (atualize o numero da versão)
    git commit -m "update 20 - entrega final" (atualize o texto dentro das aspas)
    .\s5-update-project.bat (rode o script no powershell)

2 - Execute o item 13;

    13 - Volte para o Powershell e execute o script s2-load-kubernetes.bat (script para windows). Ele irá fazer o deployment das imagens do docker carregadas anteriormente no docker hub, para dentro dos pods do kubernetes:
        .\s2-load-kubernetes.bat

3 - Atualize a pagina do browser e insira os dados



### Observações:

Diferenças entre esse projeto e o projeto 'k8s-projeto2':

1 - Primeira modificaçao: o arquivo script.sh foi substituido pelo arquivo cicd.yml dentro de .github/workflows

2 - No arquivo cicd.yml estao as chaves secretas para acesso ao docker hub. Os valores das chaves estao guardados no github Actions secrets

3 - crie o arquivo secrets.yml e delete-o após carregá-lo

4 - Outros comandos relacionados:
minikube start >>
minikube status >>
minikube stop >>
minikube delete >>
minikube ssh
