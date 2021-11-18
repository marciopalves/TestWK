unit uPedidoControl;

interface

Uses FireDAC.Comp.Client, FireDAC.DatS, FireDac.Phys, uPedidoModel, uAcaoEnum;

  type TPedidoControl = class

  private
    FPedido: TPedido;

  public
    property Pedido: TPedido read FPedido Write FPedido;

    constructor Create;
    destructor Destroy; Override;

    function Salvar : Boolean;
    function ProximoNumero: Integer;
    function BuscarPedido(const pNumero: Integer):TFDQuery;
    function BuscarItensPedido(const pId: Integer):TFDQuery;
    function ExcluirPedido(const pCodigo: Integer):Boolean;

  end;
implementation

{ TPedidoControl }

uses uPedidoDao;

function TPedidoControl.BuscarItensPedido(const pId: Integer): TFDQuery;
Var
  vPedidoDao: TPedidoDao;
begin
  vPedidoDao := TPedidoDao.Create;
  try
    result := vPedidoDao.BuscaItensPedido(pId);
  finally
    vPedidoDao.Free;
  end;
end;

function TPedidoControl.BuscarPedido(const pNumero: Integer): TFDQuery;
Var
  vPedidoDao: TPedidoDao;
begin
  vPedidoDao := TPedidoDao.Create;
  try
    result := vPedidoDao.BuscaPedido(pNumero);
  finally
    vPedidoDao.Free;
  end;
end;

constructor TPedidoControl.Create;
begin
  FPedido := TPedido.create;
end;

destructor TPedidoControl.Destroy;
begin
  FPedido.Free;
  inherited;
end;

function TPedidoControl.ExcluirPedido(const pCodigo: Integer): Boolean;
Var
  vPedidoDao: TPedidoDao;
begin
  vPedidoDao := TPedidoDao.Create;
  try
    result := vPedidoDao.Excluir(pCodigo);
  finally
    vPedidoDao.Free;
  end;
end;

function TPedidoControl.ProximoNumero: Integer;
Var
  vPedidoDao: TPedidoDao;
begin
  vPedidoDao := TPedidoDao.Create;
  try
    result := vPedidoDao.ProximoNumero;
  finally
    vPedidoDao.Free;
  end;
end;

function TPedidoControl.Salvar: Boolean;
Var
  vPedidoDao: TPedidoDao;
begin
  case Pedido.State of
    acIncluir: vPedidoDao.Incluir(Pedido);
    acAlterar: vPedidoDao.Alterar(Pedido);
  end;
end;

end.
