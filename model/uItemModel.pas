unit uItemModel;

interface

uses uProdutoModel, uAcaoEnum;

type
  TItemPedido = class
  private
    FIdPedido: Integer;
    FIdItem: Double;
    FProduto: TProdutoModel;
    FQtd: Double;
    FTotalItem: Double;

    procedure TotalizarItem;

  public
    property IdPedido: Integer read FIdPedido write FIdPedido;
    property IdItem: Double read FIdItem write FIdItem;
    property Produto: TProdutoModel read FProduto;
    property Qtd: Double read FQtd;
    property TotalItem: Double read FTotalItem;


    procedure SetQtd(const pValue: Double);
    procedure SetProduto(const pValue: TProdutoModel);
  end;

implementation

{ TItemPedido }

procedure TItemPedido.SetProduto(const pValue: TProdutoModel);
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
