-- Criando o banco de dados
CREATE DATABASE loja;
GO

USE loja;
GO

-- Criando a sequence para identificadores de Pessoa
CREATE SEQUENCE SeqPessoa
    AS INT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 10;
GO

-- Criando tabela Usuario
CREATE TABLE Usuario (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(100) NOT NULL,
    Senha NVARCHAR(100) NOT NULL
);
GO

-- Criando tabela Pessoa
CREATE TABLE Pessoa (
    PessoaID INT PRIMARY KEY DEFAULT NEXT VALUE FOR SeqPessoa,
    Nome NVARCHAR(100) NOT NULL,
    Endereco NVARCHAR(255),
    Telefone NVARCHAR(20),
    TipoPessoa CHAR(1) CHECK (TipoPessoa IN ('F', 'J'))
);
GO

-- Criando tabela PessoaFisica
CREATE TABLE PessoaFisica (
    PessoaID INT PRIMARY KEY,
    CPF CHAR(11) UNIQUE NOT NULL,
    CONSTRAINT FK_PessoaFisica_Pessoa FOREIGN KEY (PessoaID) REFERENCES Pessoa(PessoaID)
);
GO

-- Criando tabela PessoaJuridica
CREATE TABLE PessoaJuridica (
    PessoaID INT PRIMARY KEY,
    CNPJ CHAR(14) UNIQUE NOT NULL,
    CONSTRAINT FK_PessoaJuridica_Pessoa FOREIGN KEY (PessoaID) REFERENCES Pessoa(PessoaID)
);
GO

-- Criando tabela Produto
CREATE TABLE Produto (
    ProdutoID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(100) NOT NULL,
    Quantidade INT NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL
);
GO

-- Criando tabela MovimentoCompra
CREATE TABLE MovimentoCompra (
    MovimentoCompraID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT,
    ProdutoID INT,
    PessoaJuridicaID INT,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10, 2) NOT NULL,
    DataCompra DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_MovimentoCompra_Usuario FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
    CONSTRAINT FK_MovimentoCompra_Produto FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID),
    CONSTRAINT FK_MovimentoCompra_PessoaJuridica FOREIGN KEY (PessoaJuridicaID) REFERENCES PessoaJuridica(PessoaID)
);
GO

-- Criando tabela MovimentoVenda
CREATE TABLE MovimentoVenda (
    MovimentoVendaID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT,
    ProdutoID INT,
    PessoaFisicaID INT,
    Quantidade INT NOT NULL,
    DataVenda DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_MovimentoVenda_Usuario FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
    CONSTRAINT FK_MovimentoVenda_Produto FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID),
    CONSTRAINT FK_MovimentoVenda_PessoaFisica FOREIGN KEY (PessoaFisicaID) REFERENCES PessoaFisica(PessoaID)
);
GO
