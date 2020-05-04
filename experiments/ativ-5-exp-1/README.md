## Atividade 5 - Experimento 1

O objetivo deste experimento é realizar a execução do software GROMACS com MPI na nuvem computacional. Para reproduzir tal experimento, basta seguir as instruções abaixo:

### Configurando a máquina virtual (VM) na nuvem AWS

 1. Logar-se no painel da AWS e selecionar a região **US East (N. Virginia)**;
 2. Acessar o painel EC2 (**Services -> EC2 -> Running instances**); 
 3. Clicar no botão **Launch instance**;
 4. Selecionar a Amazon Machine Image (AMI) **Ubuntu Server 18.04 LTS (HVM), SSD Volume Type**;
 5. Selecionar o tipo da instância **t2.micro** e clicar no botão **Next: Configure Instance Details**;
 6. Na seção *Advanced Details*, no campo **User data**, selecionar *as Text* e preencha com o *script* abaixo;

```
#!/bin/bash
sudo apt-get update
sudo apt-get install -y wget make gcc libgfortran3 \
sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev \
libhdf5-openmpi-dev gfortran build-essential git cmake
```

 7. Clicar no botão **Next: Add Storage**;
 8. Clicar no botão **Next: Add Tags**;
 9. Clicar no botão **Next: Configure Security Group**;
 10. Clicar no botão **Review and Launch**;
 11. Clicar no botão **Launch**;
 12. Criar um novo *key pair* fazer o *download* do mesmo;
 13. Clicar no botão **Launch Instances**.

#### Configurando a chave RSA
Configurar a chave RSA para permitir livre acesso entre as máquinas por SSH:

 1. Encontrar a VM recém criada no painel EC2, clicar sobre a mesma com o botão direito do mouse e selecionar **Connect**;
 2. Seguir as instruções indicadas na janela que se abrirá para conectar-se à VM. O comando terá a seguinte sintaxe:
```
ssh -i "<key-pair-path>" ubuntu@<public-dns>
```
 3. Uma vez conectado à VM, executar o comando abaixo:
```
ssh-keygen
```
 4. Teclar *\<enter\>* em todas as etapas desse comando, não sendo necessário entrar com qualquer informação;
 5. Executar o seguinte comando:
```
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

#### Configurando o GROMACS na VM

Executar os seguintes comandos:
```
git clone https://github.com/renejm/gromacs-mo833a.git
cd gromacs-mo833a
git checkout ativ-5-exp-1
cd experiments/ativ-5-exp-1
./build-gromacs.sh
./config-gromacs.sh
```

#### Criando a imagem da VM

Para criar outras VMs com a mesma configuração que VM recém criada, é necessário:
 1. Encontrar a VM recém criada no painel EC2, clicar sobre a mesma com o botão direito do mouse e selecionar **Image -> Create Image**; 
 2. Na janela **Create image**, preencher o campo **Image name** com o nome desejado para a imagem e o campo **Image description** com uma pequena descrição da AMI;
 3. Clicar no botão **Create Image**.
  
#### Configurando a rede

É necessário configurar a rede de forma que todas as VMs se comuniquem entre si. Para isso:
 1. Selecionar a opção **NETWORK & SECURITY -> Security Groups** no *side menu* do painel EC2;
 2. Clicar no borão **Create security group**;
 3. Preencher os campos **Security group name** e **Description**;
 4. Clicar no botão **Create security group**;
 5. Na tela seguinte, clique no botão **Edit inbound rules**;
 6. Adicionar duas novas regras, como na figura abaixo:

![](https://raw.githubusercontent.com/renejm/gromacs-mo833a/ativ-5-exp-1/experiments/ativ-5-exp-1/images/security-group.png)
 *O campo *Source* na primeira regra deve ser o próprio *security group*.

 7. Clicar no botão *Save rules*.
 
#### Criando múltiplas instâncias

Criar duas VMs baseadas na imagem (AMI) criada anteriormente. Para isso:
 
 1. Acessar o painel EC2 e clicar no botão **Launch instance**;
 2. Clicar em **My AMIs**, no *side menu*, e selecionar a imagem criada anteriormente;
 3. Selecionar o tipo da instância **t2.micro** e clicar no botão **Next: Configure Instance Details**;
 4. Alterar o campo **Number of instances** para 2;
 5. No campo **Placement group**, selecionar **Add instance to placement group** e **Add to a new placement group**, dando um nome para o novo *placement group*;
 6. Clicar no botão **Next: Add Storage**;
 7. Clicar no botão **Next: Add Tags**;
 8. Clicar no botão **Next: Configure Security Group**;
 9. No campo **Assign a security group**, selecionar **Select an existing security group**, selecionando o *security group* criado anteriormente;
 10. Clicar no botão **Review and Launch**;
 11. Clicar no botão **Launch**;
 12. Selecionar a *key pair* criada anteriormente;
 13. Clicar no botão **Launch Instances**.

#### Executando o GROMACS em paralelo na nuvem

 1. Acessar cada uma das VMs recém criadas e configurar o arquivo ```hostfile``` através dos seguintes comandos:
```
echo "<IP1> slots=2" > hostfile
echo "<IP2> slots=2" >> hostfile
```
 onde **IP1** e **IP2** são os IPs das duas VMs recém criadas.

 2. Ir para o diretório ```experiments/exp-5-ativ-1``` e executar o comando:
```
./runexp.sh
```
