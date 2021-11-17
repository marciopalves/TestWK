unit uItemModel;

interface

uses uProdutoModel;

type
  TItemPedido = class
  private
    FIdPedido: Double;
    FIdItem: Double;
    FProduto: TProduto;
    FQtd: Double;
    FTotalItem: Double;

    procedure TotalizarItem;

  public
    property IdPedido: Double read FIdPedido write FIdPedido;
    property IdItem: Double read FIdItem write FIdItem;
    property Produto: TProduto read FProduto;
    property Qtd: Double read FQtd;
    property TotalItem: Double read FTotalItem;

    procedure SetQtd(const pValue: Double);
    procedure SetProduto(const pValue: TProduto);
  end;

implementation

{ TItemPedido }

procedure TItemPedido.SetProduto(const pValue: TProduto);
begin
  FProduto := pValue;
  TotalizarItem;
end;

procedure TItemPedido.setQtd(const pValue: Double);
begin
  FQtd := pValue;
  TotalizarItem;
end;

procedure TItemPedido.TotalizarItem;
begin
  if ( Qtd > 0) And (Produto <> nil) then
  begin
    FTotalItem := (Produto.preco * Qtd);
  end;
end;

end.
