unit uClienteDao;

interface

Uses uClienteModel;

type
  TClienteDao = Class

  public
    constructor Create;
    function GetCliente(const pCodigo: Double):TCliente;

  End;


implementation

{ TClienteDao }

Const
  SELECT_CLIENTE = 'SELECT CODIGO, NOME, CIDADE, UF FROM CLIENTE WHERE CODIGO = :CODIGO';

constructor TClienteDao.Create;
begin

end;

function TClienteDao.GetCliente(const pCodigo: Double): TCliente;
Var
  vCliente: TCliente;
begin
  result := vCliente;
end;

end.
