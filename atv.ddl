-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2026-11-04 17:57:24 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE Cliente 
    ( 
     Id                      VARCHAR2 (10)  NOT NULL , 
     Email                   VARCHAR2 (50)  NOT NULL , 
     Primeiro_Nome           VARCHAR2 (20)  NOT NULL , 
     Segundo_Nome            VARCHAR2 (20)  NOT NULL , 
     Telefone                NUMBER (15)  NOT NULL , 
     Saldo                   NUMBER (15,2)  NOT NULL , 
     Representande_vendas_Id VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE Cliente 
    ADD CONSTRAINT Cliente_PK PRIMARY KEY ( Id, Representande_vendas_Id ) ;

ALTER TABLE Cliente 
    ADD CONSTRAINT Cliente_Email_UN UNIQUE ( Email ) ;

CREATE TABLE Cliente_Endereço 
    ( 
     Id          VARCHAR2 (10)  NOT NULL , 
     Endereco1   VARCHAR2 (100)  NOT NULL , 
     Endereco2   VARCHAR2 (100) , 
     Cidade      VARCHAR2 (100)  NOT NULL , 
     Cep         NUMBER (15)  NOT NULL , 
     Cliente_Id  VARCHAR2 (10)  NOT NULL , 
     Cliente_Id1 VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE Cliente_Endereço 
    ADD CONSTRAINT Cliente_Endereço_PK PRIMARY KEY ( Id, Cliente_Id, Cliente_Id1 ) ;

CREATE TABLE Historico_preco 
    ( 
     Data_inicial       DATE  NOT NULL , 
     Hora_inicial       DATE  NOT NULL , 
     Preco              NUMBER (15,2)  NOT NULL , 
     Data_Final         DATE , 
     Hora_Final         DATE , 
     Item_Numero        NUMBER (15)  NOT NULL , 
     Item_Inventario_Id NUMBER (15)  NOT NULL 
    ) 
;

ALTER TABLE Historico_preco 
    ADD CONSTRAINT Historico_preco_PK PRIMARY KEY ( Data_inicial, Item_Numero, Item_Inventario_Id ) ;

CREATE TABLE Individual 
    ( 
     Id                  VARCHAR2 (10)  NOT NULL , 
     n°_CartaoFidelidade NUMBER (20)  NOT NULL , 
     Id1                 VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE Individual 
    ADD CONSTRAINT Individual_PK PRIMARY KEY ( Id, Id1 ) ;

CREATE TABLE Inventario 
    ( 
     Id              NUMBER (15)  NOT NULL , 
     Custo_unitario  NUMBER (15,2)  NOT NULL , 
     Unidade_em_maos VARCHAR2 (15)  NOT NULL 
    ) 
;

ALTER TABLE Inventario 
    ADD CONSTRAINT Inventario_PK PRIMARY KEY ( Id ) ;

CREATE TABLE Item 
    ( 
     Numero        NUMBER (15)  NOT NULL , 
     Name          VARCHAR2 (50)  NOT NULL , 
     Descrição     VARCHAR2 (100)  NOT NULL , 
     Categoria     VARCHAR2 (100)  NOT NULL , 
     Cor           VARCHAR2 (20) , 
     Tamanho       VARCHAR2 (15) , 
     Inventario_Id NUMBER (15)  NOT NULL 
    ) 
;

ALTER TABLE Item 
    ADD CONSTRAINT Item_PK PRIMARY KEY ( Numero, Inventario_Id ) ;

CREATE TABLE Item_Pedido 
    ( 
     Quantidade_Solicitada NUMBER (15)  NOT NULL , 
     Quantidade_Enviada    NUMBER (15)  NOT NULL , 
     Pedido_Id             VARCHAR2 (10)  NOT NULL , 
     Item_Numero           NUMBER (15)  NOT NULL , 
     Item_Inventario_Id    NUMBER (15)  NOT NULL 
    ) 
;

ALTER TABLE Item_Pedido 
    ADD CONSTRAINT Item_Pedido_PK PRIMARY KEY ( Pedido_Id, Item_Numero, Item_Inventario_Id ) ;

CREATE TABLE Pedido 
    ( 
     Id             VARCHAR2 (10)  NOT NULL , 
     Data           DATE  NOT NULL , 
     Time           DATE  NOT NULL , 
     N°_de_Unidades VARCHAR2 (10)  NOT NULL , 
     Cliente_Id     VARCHAR2 (10)  NOT NULL , 
     Cliente_Id1    VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE Pedido 
    ADD CONSTRAINT Pedido_PK PRIMARY KEY ( Id ) ;

CREATE TABLE Representande 
    ( 
     Id              VARCHAR2 (10)  NOT NULL , 
     Equipe_pertence VARCHAR2 (50)  NOT NULL , 
     Id1             VARCHAR2 (50)  NOT NULL 
    ) 
;

COMMENT ON COLUMN Representande.Equipe_pertence IS 'Equipe a qual pertence' 
;

ALTER TABLE Representande 
    ADD CONSTRAINT Representande_PK PRIMARY KEY ( Id, Id1 ) ;

CREATE TABLE Representande_vendas 
    ( 
     Id                      VARCHAR2 (50)  NOT NULL , 
     Email                   VARCHAR2 (50)  NOT NULL , 
     Primeiro_Nome           VARCHAR2 (50)  NOT NULL , 
     Segundo_Nome            VARCHAR2 (50)  NOT NULL , 
     Telefone                NUMBER (15)  NOT NULL , 
     Taxa_Comissão           NUMBER (10,2)  NOT NULL , 
     Id_Supervisor           VARCHAR2 (10)  NOT NULL , 
     Representande_vendas_Id VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE Representande_vendas 
    ADD CONSTRAINT Representande_vendas_PK PRIMARY KEY ( Id ) ;

ALTER TABLE Representande_vendas 
    ADD CONSTRAINT Representande_vendas_Email_UN UNIQUE ( Email ) ;

CREATE TABLE Time 
    ( 
     Id                VARCHAR2 (15)  NOT NULL , 
     Nome              VARCHAR2 (15)  NOT NULL , 
     N°_Jogadores      NUMBER (15)  NOT NULL , 
     Desconto          VARCHAR2 (3) , 
     Representande_Id  VARCHAR2 (10)  NOT NULL , 
     Representande_Id1 VARCHAR2 (50)  NOT NULL 
    ) 
;

COMMENT ON COLUMN Time.Desconto IS 'Desconto, sera sim ou não' 
;
CREATE UNIQUE INDEX Time__IDX ON Time 
    ( 
     Representande_Id ASC , 
     Representande_Id1 ASC 
    ) 
;

ALTER TABLE Time 
    ADD CONSTRAINT Time_PK PRIMARY KEY ( Id ) ;

CREATE TABLE Vendas_Rep_endereco 
    ( 
     Id                      VARCHAR2 (10)  NOT NULL , 
     Endereco1               VARCHAR2 (100)  NOT NULL , 
     Endereco2               VARCHAR2 (100) , 
     Cidade                  VARCHAR2 (100)  NOT NULL , 
     Cep                     NUMBER (15)  NOT NULL , 
     Representande_vendas_Id VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE Vendas_Rep_endereco 
    ADD CONSTRAINT Vendas_Rep_endereco_PK PRIMARY KEY ( Representande_vendas_Id ) ;

ALTER TABLE Cliente_Endereço 
    ADD CONSTRAINT Cliente_Endereço_Cliente_FK FOREIGN KEY 
    ( 
     Cliente_Id,
     Cliente_Id1
    ) 
    REFERENCES Cliente 
    ( 
     Id,
     Representande_vendas_Id
    ) 
;

ALTER TABLE Cliente 
    ADD CONSTRAINT Cliente_RepVendas_FK FOREIGN KEY 
    ( 
     Representande_vendas_Id
    ) 
    REFERENCES Representande_vendas 
    ( 
     Id
    ) 
;

ALTER TABLE Historico_preco 
    ADD CONSTRAINT Historico_preco_Item_FK FOREIGN KEY 
    ( 
     Item_Numero,
     Item_Inventario_Id
    ) 
    REFERENCES Item 
    ( 
     Numero,
     Inventario_Id
    ) 
;

ALTER TABLE Individual 
    ADD CONSTRAINT Individual_Cliente_FK FOREIGN KEY 
    ( 
     Id,
     Id1
    ) 
    REFERENCES Cliente 
    ( 
     Id,
     Representande_vendas_Id
    ) 
;

ALTER TABLE Item 
    ADD CONSTRAINT Item_Inventario_FK FOREIGN KEY 
    ( 
     Inventario_Id
    ) 
    REFERENCES Inventario 
    ( 
     Id
    ) 
;

ALTER TABLE Item_Pedido 
    ADD CONSTRAINT Item_Pedido_Item_FK FOREIGN KEY 
    ( 
     Item_Numero,
     Item_Inventario_Id
    ) 
    REFERENCES Item 
    ( 
     Numero,
     Inventario_Id
    ) 
;

ALTER TABLE Item_Pedido 
    ADD CONSTRAINT Item_Pedido_Pedido_FK FOREIGN KEY 
    ( 
     Pedido_Id
    ) 
    REFERENCES Pedido 
    ( 
     Id
    ) 
;

ALTER TABLE Pedido 
    ADD CONSTRAINT Pedido_Cliente_FK FOREIGN KEY 
    ( 
     Cliente_Id,
     Cliente_Id1
    ) 
    REFERENCES Cliente 
    ( 
     Id,
     Representande_vendas_Id
    ) 
;

ALTER TABLE Representande 
    ADD CONSTRAINT Representande_Cliente_FK FOREIGN KEY 
    ( 
     Id,
     Id1
    ) 
    REFERENCES Cliente 
    ( 
     Id,
     Representande_vendas_Id
    ) 
;

ALTER TABLE Representande_vendas 
    ADD CONSTRAINT Super_vendas FOREIGN KEY 
    ( 
     Representande_vendas_Id
    ) 
    REFERENCES Representande_vendas 
    ( 
     Id
    ) 
;

ALTER TABLE Time 
    ADD CONSTRAINT Time_Representande_FK FOREIGN KEY 
    ( 
     Representande_Id,
     Representande_Id1
    ) 
    REFERENCES Representande 
    ( 
     Id,
     Id1
    ) 
;

ALTER TABLE Vendas_Rep_endereco 
    ADD CONSTRAINT VendasRep_RepVendas_FK FOREIGN KEY 
    ( 
     Representande_vendas_Id
    ) 
    REFERENCES Representande_vendas 
    ( 
     Id
    ) 
;

CREATE OR REPLACE TRIGGER FKNTM_Pedido 
BEFORE UPDATE OF Cliente_Id, Cliente_Id1 
ON Pedido 
BEGIN 
  raise_application_error(-20225,'Non Transferable FK constraint  on table Pedido is violated'); 
END; 
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             1
-- ALTER TABLE                             26
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
