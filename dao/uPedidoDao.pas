unit uPedidoDao;

interface

Uses FireDAC.Comp.Client, FireDAC.DatS, FireDac.Phys, uPedidoModel, uItemModel,
  uAcaoEnum;

  type TPedidoDao = class
    private
      function IncluirItenPedido(pItemPedido: TItemPedido):Boolean;

    public
      Constructor Create;

      function Incluir(pPedido: TPedido):Boolean;
      function Alterar(pPedido: TPedido):Boolean;
      function Excluir(const pCodigo: Integer):Boolean;
      function RemoverItens(const pCodigoItem: Integer):Boolean;
      function BuscaPedido(const pNumero: Integer):TFDQuery;
      function BuscaItensPedido(const pId: Integer):TFDQuery;
      function ProximoNumero: Integer;


  end;

implementation

{ TPedidoDao }

uses uDmConexao, System.SysUtils;

Const
  SQL_DELETE_ITENS = 'DELETE FROM ITENSPEDIDO WHERE IDPEDIDO = :ID';

constructor TPedidoDao.Create;
begin

end;

function TPedidoDao.RemoverItens(const pCodigoItem: Integer): Boolean;
Var
  vQry: TFDQuery;
  vTransacao: Boolean; // Para saber se já estava em transação na chamada do metodo
                       // Se não ele starta e faz os commits
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := DMConexao.FDConnection;
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add(SQL_DELETE_ITENS);
    vQry.ParamByName('ID').AsInteger := pCodigoItem;
    try
      vTransacao := DMConexao.FDConnection.InTransaction;
      if Not (vTransacao) then
        DMConexao.FDConnection.StartTransaction;
      vQry.ExecSQL;
      if Not (vTransacao) then
        DMConexao.FDConnection.Commit;
    except
      on e:exception do
      begin
        if Not (vTransacao) then
          DMConexao.FDConnection.Rollback;
        raise Exception.Create('Erro remover Item.:'+intToStr(pCodigoItem)+
                               sLineBreak+
                               e.ToString);
      end;
    end;
  finally
    FreeAndNil(vQry);
  end;
end;

function TPedidoDao.Incluir(pPedido: TPedido): Boolean;
Const
  SQL_INSERT_PEDIDO = 'INSERT INTO PEDIDO(NUMERO, CODCLI, DTCADASTRO, TOTAL)'+
                      'VALUES(:NUMERO, :CODCLI, :DTCADASTRO, :TOTAL);';
Var
  vQry: TFDQuery;
  vIdPedido: Integer;
  vItemPedido: TItemPedido;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := DMConexao.FDConnection;
    vQry.Close;
    vQry.SQL.Clear;
    try
      DMConexao.FDConnection.StartTransaction;
      vQry.SQL.Add(SQL_INSERT_PEDIDO);
      vQry.ParamByName('NUMERO').AsFloat    := pPedido.Numero;
      vQry.ParamByName('CODCLI').AsFloat    := pPedido.Cliente.Codigo;
      vQry.ParamByName('DTCADASTRO').AsDate := Now;
      vQry.ParamByName('TOTAL').AsFloat     := pPedido.Total;
      vQry.ExecSQL;

      for vItemPedido in pPedido.ListaItens do
      begin
        IncluirItenPedido(vItemPedido);
      end;

      DMConexao.FDConnection.Commit;
      Result := True;
    except
      on e:exception do
      begin
        DMConexao.FDConnection.Rollback;
        raise Exception.Create('Erro ao incluir pedido!'+sLineBreak+e.ToString);
      end;
    end;

  finally
    FreeAndNil(vQry);
  end;
end;

function TPedidoDao.IncluirItenPedido(pItemPedido: TItemPedido):Boolean;
Const
SQL_INSERT_ITEMPEDIDO = 'INSERT INTO ITENSPEDIDO (IDPEDIDO, CODPROD, QTD, PRECO, TOTALITEM)'+
                        ' VALUES(:IDPEDIDO, :CODPROD, :QTD, :PRECO, :TOTALITEM)';
Var
  vQry: TFDQuery;
begin
  vQry.Connection := DMConexao.FDConnection;
  try
    vQry.Close;
    vQry.SQL.Clear;
    try
      vQry.SQL.Add(SQL_INSERT_ITEMPEDIDO);
      vQry.ParamByName('IDPEDIDO').AsInteger := pItemPedido.IdPedido;
      vQry.ParamByName('CODPROD').AsFloat    := pItemPedido.Produto.Codigo;
      vQry.ParamByName('QTD').AsFloat        := pItemPedido.Qtd;
      vQry.ParamByName('PRECO').AsFloat      := pItemPedido.Produto.Preco;
      vQry.ParamByName('TOTALITEM').AsFloat  := pItemPedido.TotalItem;
      vQry.ExecSQL;
      result := true;
    except on e:exception do
      raise Exception.Create('Erro ao incluir item!'+sLineBreak+e.ToString);
    end;
  finally
    FreeAndNil(vQry);
  end;
end;

function TPedidoDao.ProximoNumero: Integer;
Var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := DMConexao.FDConnection;
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add('SELECT COALESCE(MAX(NUMERO),0)+1 as NUMERO FROM PEDIDO');
    vQry.Open;
    result := vQry.FieldByName('NUMERO').AsInteger;
  finally
    vQry.Free;
  end;
end;

function TPedidoDao.Alterar(pPedido: TPedido): Boolean;
Const
SQL_UPDATE_PEDIDO = 'UPDATE PEDIDO SET CODCLI = :CODCLI, DTCADASTRO=:DTCADASTRO'+
                    'TOTAL =:TOTAL WHERE IDPEDIDO =:IDPEDIDO';
Var
  vQry: TFDQuery;
  vItemPedido: TItemPedido;

  procedure AlterarItenPedido(pItemPedido: TItemPedido);
  Const
    SQL_UPDATE_ITEM = 'UPDATE ITEMPEDIDO SET CODPROD=:CODPROD, QTD=:QTD, PRECO=:PRECO,'+
                      'TOTALITEM=:TOTALITEM WHEERE IDITEM=:IDTEM';
  Var
    vQry: TFDQuery;
  begin
    vQry := TFDQuery.Create(nil);
    try
      vQry.Connection := DMConexao.FDConnection;
      vQry.Close;
      vQry.SQL.Clear;
      vQry.SQL.Add(SQL_UPDATE_ITEM);
    finally
      FreeAndNil(vQry);
    end;
  end;

begin
  try
    vQry := TFDQuery.Create(nil);
    vQry.Connection := DMConexao.FDConnection;
    vQry.Close;
    vQry.SQL.Clear;
    try
       vQry.SQL.Add(SQL_UPDATE_PEDIDO);
       vQry.ParamByName('CODCLI').AsFloat    := pPedido.Cliente.Codigo;
       vQry.ParamByName('DTCADASTRO').AsDate := pPedido.Data;
       vQry.ParamByName('TOTAL').AsFloat     := pPedido.Total;
       DMConexao.FDConnection.StartTransaction;
       vQry.ExecSQL;

       for vItemPedido in pPedido.ListaItens do
       begin
         if (vItemPedido.IdItem = 0) then
           IncluirItenPedido(vItemPedido)
         else
           AlterarItenPedido(vItemPedido);
       end;
       DMConexao.FDConnection.Commit;
       result := true;
    except
      on e:exception do
      begin
        DMConexao.FDConnection.Rollback;
        raise Exception.Create('Erro ao Editar Pedido!'+e.ToString);
      end;
    end;
  finally
    FreeAndNil(vQry);
  end;
end;

function TPedidoDao.Excluir(const pCodigo: Integer): Boolean;
Var
  vQry: TFDQuery;
begin
  try
    vQry := TFDQuery.Create(nil);
    vQry.Connection := DMConexao.FDConnection;
    vQry.Close;
    vQry.SQL.Clear;
    try
      DMConexao.FDConnection.StartTransaction;
      RemoverItens(pCodigo);

      vQry.SQL.Add('DELETE FROM PEDIDO WHERE IDPEDIDO = :ID');
      vQry.ParamByName('ID').AsInteger := pCodigo;
      vQry.ExecSQL;
      DMConexao.FDConnection.Commit;
    except
      on e:exception do
      begin
        DMConexao.FDConnection.Rollback;
        raise Exception.Create('Erro ao excluir Pedido!'+e.ToString);
      end;
    end;

  finally
    FreeAndNil(vQry);
  end;
end;

function TPedidoDao.BuscaItensPedido(const pId: Integer): TFDQuery;
Const
  SQL_BUSCA_ITENS = ' SELECT IDPEDIDO, IDITEM, CODPROD, QT, PRECO, TOTALITEM'+
                    ' FROM ITENSPEDIDO WHERE IDPEDIDO =:IDPEDIDO';
Var
  vQry: TFDQuery;
begin
  try
    vQry := TFDQuery.Create(nil);
    vQry.Connection := DMConexao.FDConnection;
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add(SQL_BUSCA_ITENS);
    vQry.ParamByName('IDPEDIDO').AsInteger := pId;
    vQry.Open();
    result := vQry;
  except on e:Exception do
    begin
      raise Exception.Create('Erro ao buscar Itens do pedido!'+e.Message);
    end;
  end;
end;

function TPedidoDao.BuscaPedido(const pNumero: Integer): TFDQuery;
Const
  SQL_BUSCA_PEDIDO = ' SELECT IDPEDIDO, NUMERO, CODCLI, DTCADASTRO, C.NOME As CLIENTE'+
                     ' FROM PEDIDO P'+
                     ' LEFT JOIN CLIENTE C ON P.CODCLI = C.CODCLI'+
                     ' WHERE P.NUMERO = :NUMERO;';
Var
  vQry: TFDQuery;
begin
  try
    vQry := TFDQuery.Create(nil);
    vQry.Connection := DMConexao.FDConnection;
    vQry.Close;
    vQry.SQL.Clear;
    vQry.SQL.Add(SQL_BUSCA_PEDIDO);
    vQry.ParamByName('NUMERO').AsInteger := pNumero;
    vQry.Open();
    result := vQry;
  except on e:Exception do
    begin
      raise Exception.Create('Erro ao buscar Pedido!'+e.Message);
    end;
  end;
end;

end.
