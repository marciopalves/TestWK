unit uProdutoControl;

interface

uses uProdutoModel, FireDAC.Comp.Client, FireDAC.DatS, FireDac.Phys;

type
  TProdutoControl = class

    public
      function GetProduto(const pCodigo: Integer):TProdutoModel;
      function BuscarPorCodigo(const pCodigo: Integer):TFDQuery;
      function BuscarPorNome(const pNome: String):TFDQuery;
  end;

implementation

Uses uProdutoDao;

{ TProdutoControl }

function TProdutoControl.BuscarPorCodigo(
  const pCodigo: Integer): TFDQuery;
Var
  vProdutoDao: TProdutoDao;
begin
  vProdutoDao := TProdutoDao.Create();
  try
    result :=  vProdutoDao.BuscaPorCodigo(pCodigo);
  finally
    vProdutoDao.Free;
  end;
end;

function TProdutoControl.BuscarPorNome(const pNome: String): TFDQuery;
Var
  vProdutoDao: TProdutoDao;
begin
  vProdutoDao := TProdutoDao.Create();
  try
    result :=  vProdutoDao.BuscarPorNome(pNome);
  finally
    vProdutoDao.Free;
  end;
end;

function TProdutoControl.GetProduto(const pCodigo: Integer): TProdutoModel;
Var
  vProdutoDao: TProdutoDao;
begin
  vProdutoDao := TProdutoDao.Create();
  try
    result :=  vProdutoDao.GetProduto(pCodigo);
  finally
    vProdutoDao.Free;
  end;

end;

end.
