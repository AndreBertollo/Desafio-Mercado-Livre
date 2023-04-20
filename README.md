# Desafio Mercado Livre - Senior Analytics Engineer 

##Construir um dashboard analisando a evolução, crescimento de internet, usuários, assinantes, etc na Argentina e suas causas.

### Estratégia de desenvolvimento 🚚

Identificar o que explica o crescimento do acesso a internet na Argentina e como impacta o público alvo do Mercado Livre Marketplace e Mercado Ads, utilizando dados macroeconômicos e de monitoramento do site.

Com isso, traçar estratégias de como potencializar os dois modelos de negócio nesse cenário.

### Metodologia 🚚

#### ANÁLISE DE MERCADO - ARGENTINA

A análise de mercado contou com uma abordagem econômica e social da Argentina, permitindo obter uma perspectiva de cenário para o segmento de serviços, além de uma análise de mudança de hábitos na sociedade. Para isso, foram utilizadas as seguintes bases:



(i) worldbank - 'Indicadores del desarrollo mundial - Personas que usan Internet';

(ii) worldbank - 'Indicadores del desarrollo mundial - Tasa de interés activa';

(iii) worldbank - 'Indicadores del desarrollo mundial - Población activa';



A análise, no entanto, não permitiu traçar o público alvo, uma vez que não foram utilizados bases internas com característica do público atendido pelo Mercado Livre. Sendo assim , o objetivo do estudo foi analisar o contexto Argentino para o Marketplace e o segmento de anúncios de forma macro.



Os dados disponibilizados traziam a série histórica até 2021, não permitindo identificar os indicadores em 2022.

#### ANÁLISE DO SITE - MELI ARGENTINA

Para se obter uma análise do comportamento das pessoas que acessam a plataforma do mercado livre, foi utilizada a base do similarweb, que dispõe informações de performance de sites em diferentes segmentos e países. De forma geral, o site permite analisar: 



(i) Histórico de visualizações; 

(ii) Device utilizado;

(iii) Comportamento no site;

(iv) País de acesso;

(v) Ranking no país e global.



Por o estudo contar com o acesso gratuito, houve uma limitação, sobretudo, no histórico de dados. Sendo possível extrair apenas dados referentes ao último mês.


### Dashboard da solução 🚚

O Dashboard de análise pode ser acessado no link: 
https://app.powerbi.com/view?r=eyJrIjoiMTdkZTZhYTQtMjM1YS00YWU2LWI5NzQtNWMzOTEyODgyZWU4IiwidCI6IjgwNjViMmVmLTYwMjMtNDY1NC04ZTBmLTJlNmU0NWMyY2I3NCJ9

## Challenge Engineer - Primera Parte - SQL

### Objetivo

A partir do fluxo do cliente na compra de uma mercadoria no marketplace, desenha uma DER de modelagem de dados e queries que permitam realizar análises no histórico de compra através das tabelas Customer, Order, Item, Category.

### DER do modelo de dados

DER:
![image](https://github.com/AndreBertollo/Desafio-Mercado-Livre/blob/76341c0e7f5da6ce9572869eba494cb137223da8/Challenge%20Engineer%20-%20Primera%20Parte%20-%20SQL/DRE%20do%20modelo%20de%20dados.jpg)


## Challenge Engineer - Segunda Parte - APIs

### Objetivo

O intuito do desafio é construir um script que permita realizar consultas através do método get em uma API do Mercado Livre, afim de obter informações sobre os produtos ofertados no site na categoria dispositivos de smart TV.

### Desenvolvimento

O código python 'get item' realiza uma busca para os dispositivos 'Google Home', 'Apple TV', 'Amazon Fire TV','chromecast', limitando o resultado da busca em 50.

Para cada item identificado, é realizada uma nova busca na API, a fim de coletar as informações sobre o produto anunciado.

Por fim, o resultado é organizado em um json que segue o seguinte schema:

[{
	'device':'<nome do device>',
	'itens':'<array com informações sobre os itens referentes aquele device'>
 }
]

o arquivo 'retorno da consulta.json' contém o resultado da consulta realizada.