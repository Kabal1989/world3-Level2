-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- loja.dbo.Pessoa definition

-- Drop table

-- DROP TABLE loja.dbo.Pessoa;

CREATE TABLE loja.dbo.Pessoa (
	PessoaID int IDENTITY(1,1) NOT NULL,
	Nome nvarchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	Endereco nvarchar(255) COLLATE Latin1_General_CI_AS NULL,
	Telefone nvarchar(20) COLLATE Latin1_General_CI_AS NULL,
	TipoPessoa char(1) COLLATE Latin1_General_CI_AS NULL,
	CONSTRAINT PK__Pessoa__2F5F5632F8111EC5 PRIMARY KEY (PessoaID)
);
ALTER TABLE loja.dbo.Pessoa WITH NOCHECK ADD CONSTRAINT CK__Pessoa__TipoPess__3A81B327 CHECK (([TipoPessoa]='J' OR [TipoPessoa]='F'));


-- loja.dbo.Produto definition

-- Drop table

-- DROP TABLE loja.dbo.Produto;

CREATE TABLE loja.dbo.Produto (
	ProdutoID int IDENTITY(1,1) NOT NULL,
	Nome nvarchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	Quantidade int NOT NULL,
	Preco decimal(10,2) NOT NULL,
	CONSTRAINT PK__Produto__9C8800C386C54574 PRIMARY KEY (ProdutoID)
);


-- loja.dbo.Usuario definition

-- Drop table

-- DROP TABLE loja.dbo.Usuario;

CREATE TABLE loja.dbo.Usuario (
	UsuarioID int IDENTITY(1,1) NOT NULL,
	Nome nvarchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	Senha nvarchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT PK__Usuario__2B3DE798C3424E15 PRIMARY KEY (UsuarioID)
);


-- loja.dbo.Movimentacao definition

-- Drop table

-- DROP TABLE loja.dbo.Movimentacao;

CREATE TABLE loja.dbo.Movimentacao (
	MovimentacaoID int IDENTITY(1,1) NOT NULL,
	Tipo char(1) COLLATE Latin1_General_CI_AS NULL,
	ProdutoID int NULL,
	Quantidade int NULL,
	Preco decimal(10,2) NULL,
	DataMovimentacao date NULL,
	PessoaID int NULL,
	CONSTRAINT PK__Moviment__509C01B50512867D PRIMARY KEY (MovimentacaoID),
	CONSTRAINT FK_Pessoa FOREIGN KEY (PessoaID) REFERENCES loja.dbo.Pessoa(PessoaID),
	CONSTRAINT FK_Produto FOREIGN KEY (ProdutoID) REFERENCES loja.dbo.Produto(ProdutoID)
);
ALTER TABLE loja.dbo.Movimentacao WITH NOCHECK ADD CONSTRAINT CK__Movimentac__Tipo__6C190EBB CHECK (([Tipo]='S' OR [Tipo]='E'));


-- loja.dbo.PessoaFisica definition

-- Drop table

-- DROP TABLE loja.dbo.PessoaFisica;

CREATE TABLE loja.dbo.PessoaFisica (
	PessoaID int NOT NULL,
	CPF char(11) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT PK__PessoaFi__2F5F5632A2F1B545 PRIMARY KEY (PessoaID),
	CONSTRAINT UQ__PessoaFi__C1F8973136D7731D UNIQUE (CPF),
	CONSTRAINT FK_PessoaFisica_Pessoa FOREIGN KEY (PessoaID) REFERENCES loja.dbo.Pessoa(PessoaID)
);


-- loja.dbo.PessoaJuridica definition

-- Drop table

-- DROP TABLE loja.dbo.PessoaJuridica;

CREATE TABLE loja.dbo.PessoaJuridica (
	PessoaID int NOT NULL,
	CNPJ char(14) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT PK__PessoaJu__2F5F56327A186D82 PRIMARY KEY (PessoaID),
	CONSTRAINT UQ__PessoaJu__AA57D6B473AE03B7 UNIQUE (CNPJ),
	CONSTRAINT FK_PessoaJuridica_Pessoa FOREIGN KEY (PessoaID) REFERENCES loja.dbo.Pessoa(PessoaID)
);


-- loja.dbo.MovimentoCompra definition

-- Drop table

-- DROP TABLE loja.dbo.MovimentoCompra;

CREATE TABLE loja.dbo.MovimentoCompra (
	MovimentoCompraID int IDENTITY(1,1) NOT NULL,
	UsuarioID int NULL,
	ProdutoID int NULL,
	PessoaJuridicaID int NULL,
	Quantidade int NOT NULL,
	PrecoUnitario decimal(10,2) NOT NULL,
	DataCompra datetime DEFAULT getdate() NULL,
	CONSTRAINT PK__Moviment__B810DC073763CD9F PRIMARY KEY (MovimentoCompraID),
	CONSTRAINT FK_MovimentoCompra_PessoaJuridica FOREIGN KEY (PessoaJuridicaID) REFERENCES loja.dbo.PessoaJuridica(PessoaID),
	CONSTRAINT FK_MovimentoCompra_Produto FOREIGN KEY (ProdutoID) REFERENCES loja.dbo.Produto(ProdutoID),
	CONSTRAINT FK_MovimentoCompra_Usuario FOREIGN KEY (UsuarioID) REFERENCES loja.dbo.Usuario(UsuarioID)
);


-- loja.dbo.MovimentoVenda definition

-- Drop table

-- DROP TABLE loja.dbo.MovimentoVenda;

CREATE TABLE loja.dbo.MovimentoVenda (
	MovimentoVendaID int IDENTITY(1,1) NOT NULL,
	UsuarioID int NULL,
	ProdutoID int NULL,
	PessoaFisicaID int NULL,
	Quantidade int NOT NULL,
	DataVenda datetime DEFAULT getdate() NULL,
	CONSTRAINT PK__Moviment__006DD077BB80631F PRIMARY KEY (MovimentoVendaID),
	CONSTRAINT FK_MovimentoVenda_PessoaFisica FOREIGN KEY (PessoaFisicaID) REFERENCES loja.dbo.PessoaFisica(PessoaID),
	CONSTRAINT FK_MovimentoVenda_Produto FOREIGN KEY (ProdutoID) REFERENCES loja.dbo.Produto(ProdutoID),
	CONSTRAINT FK_MovimentoVenda_Usuario FOREIGN KEY (UsuarioID) REFERENCES loja.dbo.Usuario(UsuarioID)
);
