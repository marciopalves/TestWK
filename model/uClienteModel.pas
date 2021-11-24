unit uClienteModel;

interface

type
  TClienteModel = class
  private
    FUf: String;
    FCodigo: Double;
    FNome: String;
    FCidade: String;

  public
    property Codigo: Double read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Cidade: String read FCidade write FCidade;
    property Uf: String read FUf write FUf;

    constructor Create(const PCodigo:Double; const PNome: String; const PCidade: String; COnst pUf: String);
  end;

implementation

{ TCliente }

constructor TClienteModel.Create(const PCodigo: Double; const PNome, PCidade,
  pUf: String);
begin
  self.Codigo := pCodigo;
  self.Nome   := pNome;
  self.Cidade := pCidade;
  self.Uf     := pUf;
end;

end.
