unit uProdutoDao;

interface

Uses uProdutoModel, uProdutoModel, FireDAC.Comp.Client, FireDAC.DatS, FireDac.Phys;

type
  TProdutoDao = class

  public
    constructor create;
    function getProduto(const pCodigo: Double): TProdutoModel;
    function BuscaPorCodigo(const pCodigo: Integer):TFDQuery;
    function BuscarPorNome(const pNome: String):TFDQuery;
  end;

implementation

Uses uDmConexao, System.sysUtils;

{ TProdutoDao }

Const
  SELECT_PRODUTO = ' SELECT CODIGO, DESCRICAO, PRECO FROM PRODUTO ';
  WHERE_CODIGO   = ' WHERE CODIGO = :CODIGO';
  WHERE_NOME     = ' WHERE DESCRICAO LIKE ''%:NOME%'' ';

function TProdutoDao.getProduto(const pCodigo: Double): TProdutoModel;
Var
  vqry: TFDQuery;
begin
  vqry := BuscaPorCodigo(pCodigo);
  try
    result := vqry.AsObject<TProdutoModel>;
  finally
    vQry.Close;
  end;
end;

function TProdutoDao.BuscaPorCodigo(const pCodigo: Integer): TFDQuery;
Var
  vQry: TFDQuery;
begin
  vQry:= TFDQuery.Create(nil);
  try
    vQry.Connection := DMConexao.FDConnection;
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add(SELECT_PRODUTO);
    vQry.SQL.Add(WHERE_CODIGO);
    vQry.ParamByName('CODIGO').AsInteger := pCodigo;
    vQry.Open();
    Result := vQry;
  except
    on e: exception do
    begin
      vQry.Close;
      raise Exception.Create('Erro ao buscar cliente!'+e.ToString);
    end;
  end;
end;

function TProdutoDao.BuscarPorNome(const pNome: String): TFDQuery;
Var
  vQry: TFDQuery;
begin
  vQry:= TFDQuery.Create(nil);
  try
    vQry.Connection := DMConexao.FDConnection;
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add(SELECT_PRODUTO);
    vQry.SQL.Add(WHERE_NOME);
    vQry.ParamByName('NOME').AsString := pNome;
    vQry.Open();
    Result := vQry;
  except
    on e: exception do
    begin
      vQry.Close;
      raise Exception.Create('Erro ao buscar cliente!'+e.ToString);
    end;
  end;
end;

constructor TProdutoDao.create;
begin

end;

end.
