unit uDmConexao;

interface

uses
  System.SysUtils, System.Classes, Data.DBXMySQL, Data.DB, Data.SqlExpr,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Comp.Client;

type
  TDMConexao = class(TDataModule)
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDConnection: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarDadosIniciais: Boolean;
  end;

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMConexao }

function TDMConexao.GerarDadosIniciais: Boolean;
Const
  SQL_INSERE_PRODUTOS = 'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''AROOZ CRISTAL 5kg'', 23);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''AÇUCAR CRISTAL 5kg'', 8.75);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Feijão Ki Caldo 1kg'', 9);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Café Moinho Fino 500g'', 23.5);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Café Dulce 500g'', 18.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Café Brasileiro 500g'', 21.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Macarrão Parafuso Eliane 500g'', 2.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Macarrão Espaguete Eliane 500g'', 2.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Macarrão Espaguete Talharim 500g'', 2.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Extrato de tomate Elefante 500G'', 6.75);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Maionse Helmans 500G'', 12.75);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Margarina Sol 500G'', 7.45);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Katchup Tradicional 500G'', 6.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Yorgute Frutapinho 500ml'', 4.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Yorgute Nectar 800ml'', 9.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Yackut Lactea 500ml'', 8.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Danone 500ml'', 8.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Banana Prata Kg'', 2.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Banana Maça Kg'', 5.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Tomate Kg'', 8.99);'+
                        'INSERT INTO PRODUTO(DESCRICAO, PRECO)VALUES(''Brocolis'', 9.99);';

  SQL_INSERE_CLIENTE = ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Márcio Pereira'', ''Goiânia'', ''GO'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Jão Apolinario'', ''São Paulo'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Caito Maia'', ''Rio de Janeiro'', ''RJ'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Carol Paiffer'', ''Campinas'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Camila Farani'', ''Curitiba'', ''PR'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''José Carlos Semenzato'', ''Campinas'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Abilio Dinis'', ''Campinas'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Agnaldo Moreira'', ''Goiânia'', ''GO'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Jaime Camera'', ''Goiânia'', ''GO'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Silveirinha LDTA'', ''Rio de Janeiro'', ''RJ'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Barroso secos e Molhados'', ''Campinas'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Grupo Pereira'', ''Curitiba'', ''PR'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Fast Wash'', ''Campinas'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Caio Castro'', ''Rio de Janeiro'', ''RJ'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Laura Fonseca'', ''Osasco'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Felipe Tito'', ''Rio de Janeiro'', ''RJ'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Bruna Luise'', ''Campinas'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Afonso Padilha'', ''São Paulo'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Igor Melo'', ''Campinas'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Annita Rocha'', ''Goiânia'', ''GO'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Marcos Paulo'', ''São Paulo'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Ney Carvalho'', ''Rio de Janeiro'', ''RJ'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Luigui Baricheli'', ''Campinas'', ''SP'');'+
                       ' INSERT INTO CLIENTE(NOME, CIDADE, UF)VALUES(''Carol Fernandes'', ''Curitiba'', ''PR'');';
Var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try

    qry.Connection := FDConnection;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT COALESCE(COUNT(*), 0) QT FROM PRODUTO ');
    qry.Open();

    if (qry.IsEmpty) or (qry.FieldByName('QT').AsFloat = 0) then
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add(SQL_INSERE_PRODUTOS);
      qry.ExecSQL;
    end;

    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT COALESCE(COUNT(*),0)QT FROM CLIENTE');
    qry.Open();

    if (qry.IsEmpty) or (qry.FieldByName('QT').AsFloat = 0) then
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add(SQL_INSERE_CLIENTE);
      qry.ExecSQL;
    end;
    result := true;
  finally
    FreeAndNil(qry);
  end;
end;

end.
