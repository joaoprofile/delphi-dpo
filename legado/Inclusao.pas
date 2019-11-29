unit Inclusao;

interface

uses Classes, SysUtils, ConfigBD, Operacao;

type
  TInclusao = class(TOperacao)
  public
    class function getInclusao(tipoBanco: TTipoBanco): TInclusao;
    function getSQL: string; override;
  end;

implementation

  { TInclusao }

class function TInclusao.getInclusao(tipoBanco: TTipoBanco): TInclusao;
begin
  Result := TInclusao.Create;
end;

function TInclusao.getSQL: string;
var
  SQL: TStringList;
begin
  SQL := TStringList.Create;
  try
    with SQL do
    begin
      Add('insert into');
      Add(ident + getTabela);
      Add('(' + getCampos + ')');
      Add( 'values');
      Add('(' + getValores + ')');
    end;
    Result := SQL.Text;
  finally
    SQL.Free;
  end;
end;

end.
