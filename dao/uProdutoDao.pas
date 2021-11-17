unit uProdutoDao;

interface

Uses uProdutoModel;

type
  TProdutoDao = class

  public
    constructor create;
    function getProduto(const pCodigo: Double): TProduto;
  end;

implementation

{ TProdutoDao }

Const
  SELECT_PRODUTO = 'SELECT CODIGO, DESCRICAO, PRECO FROM PRODUTO WHERE CODIGO = :CODIGO';

constructor TProdutoDao.create;
begin

end;

function TProdutoDao.getProduto(const pCodigo: Double): TProduto;
Var
  vProduto: TProduto;
begin
  result := vProduto;
end;

end.
