unit uPedidoDao;

interface

  uses uPedidoModel;

  type TPedidoDao = class


    public
      Constructor Create;

      function Incluir(pPedido: TPedido):Boolean;
      function Alterar(pPedido: TPedido):Boolean;
      function Excluir(const pCodigo: Double):Boolean;
      function RemoverItem(const pCodigoItem):Boolean;


  end;

implementation


{ TPedidoDao }

constructor TPedidoDao.Create;
begin
//
end;

function TPedidoDao.RemoverItem(const pCodigoItem): Boolean;
begin
//
end;

function TPedidoDao.Incluir(pPedido: TPedido): Boolean;
begin
//
end;

function TPedidoDao.Alterar(pPedido: TPedido): Boolean;
begin
//
end;

function TPedidoDao.Excluir(const pCodigo: Double): Boolean;
begin
//
end;

end.
