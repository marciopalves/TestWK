object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Wk Tecnology '
  ClientHeight = 319
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu: TMainMenu
    Left = 552
    Top = 168
    object Cadastros1: TMenuItem
      Caption = '&Cadastros'
      object CadastrarPedido1: TMenuItem
        Caption = '&Cadastrar Pedido'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object CarregarBanco1: TMenuItem
        Caption = 'Carregar Dados Iniciais'
        OnClick = CarregarBanco1Click
      end
    end
  end
end
