unit Alteracao;

interface

uses Classes, SysUtils, ConfigBD, Operacao;

type
  TAlteracao = class(TOperacao)
  public
    class function getAlteracao(tipoBanco: TTipoBanco): TAlteracao;
    function getSQL: string; override;
  end;

implementation

{ TAlteracao }

class function TAlteracao.getAlteracao(tipoBanco: TTipoBanco): TAlteracao;
begin
  Result := TAlteracao.Create;
end;

function TAlteracao.getSQL: string;
var
  SQL: TStringList;

  function getCamposValores: string;
  var
    SLCampos, SLValores: TStringList;
  begin
    SLCampos := TStringList.Create;
    SLValores := TStringList.Create;
    Result := EmptyStr;
    try
      SLCampos.CommaText := getCampos;
      SLValores.CommaText := getValores;
      while SLCampos.Count > 0 do
      begin
        Result := Result + SLCampos[0] + ' = ' + SLValores[0] + #13#10;
        if SLCampos.Count > 1 then
          Result := Result + ',';
        SLCampos.Delete(0);
        SLValores.Delete(0);
      end;
    finally
      SLCampos.Free;
      SLValores.Free;
    end;
  end;

begin
  SQL := TStringList.Create;
  try
    with SQL do
    begin
      Add('update');
      Add(ident + getTabela);
      Add('set');
      Add(ident + getCamposValores);
      if Trim(getCondicao) <> EmptyStr then
      begin
        Add('where');
        Add(ident + getCondicao);
      end;
    end;
    Result := SQL.Text;
  finally
    SQL.Free;
  end;
end;

end.
