unit uProdutoModel;

interface

type
  TProduto = class
  private
    FPreco: Double;
    FDescricao: String;
    FCodigo: Double;
  public
    property Codigo: Double read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property Preco: Double read FPreco write FPreco;

    constructor create(const pCodigo: Double; const pDescricao: String; const pPreco: Double);
  end;

implementation

{ TProduto }

constructor TProduto.create(const pCodigo: Double; const pDescricao: String;
  const pPreco: Double);
begin
  self.Codigo    := pCodigo;
  self.Descricao := pDescricao;
  self.Preco     := pPreco;
end;

end.
