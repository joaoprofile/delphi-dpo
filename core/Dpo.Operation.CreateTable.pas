unit Dpo.Operation.CreateTable;

interface

uses
  Dpo.Core.Interfaces, Dpo.Core.EntityMetadata;

type
  TCreateTable = Class(TInterfacedObject, ICreateTable)
  private
    FMetadata: IEntityMetadata;
  public
    constructor Create(ADriveName: TDriverName);
    destructor Destroy; override;
    class function New(ADriveName: TDriverName): TCreateTable;

    function Metadata: IEntityMetadata;
    function SQL: string;
  End;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ TCreateTable }

class function TCreateTable.New(ADriveName: TDriverName): TCreateTable;
begin
  Result := self.Create(ADriveName);
  showmessage('CRIOU TCreateTable')
end;

constructor TCreateTable.Create(ADriveName: TDriverName);
begin
  FMetadata := TEntityMetadata.New;
  showmessage('CRIOU TEntityMetadata')
end;

destructor TCreateTable.Destroy;
begin

  inherited;
end;

function TCreateTable.Metadata: IEntityMetadata;
begin
  Result := FMetadata;
end;

function TCreateTable.SQL: string;
var
  str: TStringBuilder;
begin
   str := TStringBuilder.Create;
   try
      with str do
      begin
        Append('CREATE TABLE' + ident + Metadata.Table);
        Append('(');
        Append(Metadata.Fields);
        Append(');');
      end;
      Result := str.ToString;
   finally
      FreeAndNil(str);
   end;
end;

end.
