unit uClienteDao;

interface

Uses uClienteModel, FireDAC.Comp.Client, FireDAC.DatS, FireDac.Phys;

type
  TClienteDao = Class

  public
    constructor Create;
    function GetCliente(const pCodigo: Integer):TClienteModel;
    function BuscaClientePorCodigo(const pCodigo: Integer):TFDQuery;
    function BuscaClientePorNome(const pNome: String):TFDQuery;

  End;


implementation


Uses uDmConexao, System.SysUtils;

{ TClienteDao }

Const
  SELECT_CLIENTE = ' SELECT CODIGO, NOME, CIDADE, UF FROM CLIENTE ';
  WHERE_CODIGO   = ' WHERE CODIGO = :CODIGO';
  WHERE_NOME     = ' WHERE NOME LIKE ''%:NOME%'' ';

constructor TClienteDao.Create;
begin

end;

function TClienteDao.GetCliente(const pCodigo: Integer): TClienteModel;
Var
  vqry: TFDQuery;
begin
  vqry := BuscaClientePorCodigo(pCodigo);
  try
    result := vqry.AsObject<TClienteModel>;
  finally
    vQry.Close;
  end;
end;

function TClienteDao.BuscaClientePorCodigo(const pCodigo: Integer): TFDQuery;
Var
  vQry: TFDQuery;
begin
  vQry:= TFDQuery.Create(nil);
  try
    vQry.Connection := DMConexao.FDConnection;
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add(SELECT_CLIENTE);
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

function TClienteDao.BuscaClientePorNome(const pNome: String): TFDQuery;
Var
  vQry: TFDQuery;
begin
  vQry:= TFDQuery.Create(nil);
  try
    vQry.Connection := DMConexao.FDConnection;
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add(SELECT_CLIENTE);
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

end.
