unit uPedidoModel;

interface

Uses uClienteModel, uProdutoModel, uItemModel, uPedidoDao,
     System.Generics.Collections, System.SysUtils;



type
  TPedido = class
  private
    FCodigo: Double;
    FCliente: TCliente;
    FTotal: Double;
    FNumero: Double;
    FDAta: TDate;
    FListaItens: TobjectList<TItemPedido>;
    FIdPedido: Double;

    public
       property IdPedido: Double read FIdPedido write FIdPedido;
       property Numero: Double read FNumero write FNumero;
       property Data: TDate read FDAta write FData;
       property Cliente: TCliente read FCliente write FCliente;
       property ListaItens: TobjectList<TItemPedido> read FListaItens write FListaItens;
       property Total: Double read FTotal;

       Constructor create;
       destructor destroy; Override;

       procedure AdcionarItem(const pProduto: TProduto; const pQtd: Double);
       procedure RemoverItem(const pCodigo: Double);
       procedure SetTotal;

  end;

implementation

{ Pedido }

procedure TPedido.AdcionarItem(const pProduto: TProduto; const pQtd: Double);
Var
  vCont: Integer;
begin
  FListaItens.Add(TItemPedido.Create);
  vCont := FListaItens.Count - 1;
  FListaItens[vCont].IdPedido  := IdPedido;
  FListaItens[vCont].SetProduto(pProduto);
  FListaItens[vCont].SetQtd(pQtd);

  SetTotal;
end;

constructor TPedido.create;
begin
  Numero := 0;
  FData  := Now;
  FListaItens := TObjectList<TItemPedido>.Create;
end;

destructor TPedido.destroy;
begin
  FreeANdNil(FListaItens);
  inherited;
end;

procedure TPedido.RemoverItem(const pCodigo: Double);
Var
  vPedidoDao: TPedidoDao;
begin
  vPedidoDao.Excluir(pCodigo);

  SetTotal;
end;

procedure TPedido.SetTotal;
Var
  Item: TItemPedido;
begin
  FTotal := 0;
  try
    for Item in ListaItens do
    begin
      FTotal := FTotal + Item.TotalItem;
    end;

  except on e : exception do
    begin
      raise Exception.Create('Erro ao Totalizar Pedido!'+sLineBreak+e.ToString);
    end;
  end;

end;

end.
