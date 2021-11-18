unit uPedidoModel;

interface

Uses uClienteModel, uProdutoModel, uItemModel,
     System.Generics.Collections, System.SysUtils, uAcaoEnum;

type
  TPedido = class
  private
    FCodigo: Double;
    FCliente: TCliente;
    FTotal: Double;
    FNumero: Double;
    FDAta: TDate;
    FListaItens: TobjectList<TItemPedido>;
    FIdPedido: Integer;
    FState: TACAO;

    public
       property IdPedido: Integer read FIdPedido write FIdPedido;
       property Numero: Double read FNumero write FNumero;
       property Data: TDate read FDAta write FData;
       property Cliente: TCliente read FCliente write FCliente;
       property ListaItens: TobjectList<TItemPedido> read FListaItens write FListaItens;
       property Total: Double read FTotal;
       property State : TACAO read FState write FState;

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
begin
  //vPedidoDao.Excluir(pCodigo);

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
