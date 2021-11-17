program prjTestWk;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  uFrmCadPedidoView in 'view\uFrmCadPedidoView.pas' {uFrmCadPedido},
  uAcaoEnum in 'model\uAcaoEnum.pas',
  uProdutoModel in 'model\uProdutoModel.pas',
  uClienteModel in 'model\uClienteModel.pas',
  uClienteDao in 'dao\uClienteDao.pas',
  uProdutoDao in 'dao\uProdutoDao.pas',
  uPedidoModel in 'model\uPedidoModel.pas',
  uItemModel in 'model\uItemModel.pas',
  uPedidoDao in 'dao\uPedidoDao.pas',
  uDmConexao in 'dao\uDmConexao.pas' {DMConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TuFrmCadPedido, uFrmCadPedido);
  Application.CreateForm(TDMConexao, DMConexao);
  Application.Run;
end.
