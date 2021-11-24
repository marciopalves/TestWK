unit uClienteControl;

interface

Uses FireDAC.Comp.Client, FireDAC.DatS, FireDac.Phys, uClienteModel;

type
  TClienteControl = class
    private

    public
      function GetCliente(const pCodigo: Integer):TClienteModel;
      function BuscarPorCodigo(const pCodigo: Integer):TFDQuery;
      function BuscarPorNome(const pNome: String):TFDQuery;
  end;

implementation

uses
  uClienteDao;

{ TClienteControl }

function TClienteControl.BuscarPorCodigo(const pCodigo: Integer): TFDQuery;
Var
  vClienteDao: TClienteDao;
begin
  vClienteDao := TClienteDao.Create();
  try
    result :=  vClienteDao.BuscaClientePorCodigo(pCodigo);
  finally
    vClienteDao.Free;
  end;
end;

function TClienteControl.BuscarPorNome(const pNome: String): TFDQuery;
Var
  vClienteDao: TClienteDao;
begin
  vClienteDao := TClienteDao.Create();
  try
    result :=  vClienteDao.BuscaClientePorNome(pNome);
  finally
    vClienteDao.Free;
  end;
end;

function TClienteControl.GetCliente(const pCodigo: Integer): TClienteModel;
Var
  vClienteDao: TClienteDao;
begin
  vClienteDao := TClienteDao.Create();
  try
    result :=  vClienteDao.GetCliente(pCodigo);
  finally
    vClienteDao.Free;
  end;
end;


end.
