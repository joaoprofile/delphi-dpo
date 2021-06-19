unit Dpo.Driver.Interfaces;

interface

uses
  FireDAC.Comp.Client, Data.DB, System.Classes, System.Generics.Collections;

type
  TDriverName = (SQLite, Firebird, MySQL, Postgres, MSSQL, Oracle);

  IDPOQuery = interface
    ['{8AB93090-6A54-4B93-9D0A-CBD6A3E1C418}']
    function SQL : TStrings;
    function Params : TParams; overload;
    function SQLCommand(SQLCommand: string): IDPOQuery;
    function Dataset: TDataSet;
    function ExecuteQuery: TDataset;
    function Execute: IDPOQuery;
    function ExecSQL(SQLCommand: string): IDPOQuery; Overload;
    function ExecSQL: IDPOQuery; Overload;
  end;

  IDPOTransaction = interface
    ['{D33DB48E-42DE-4ED9-8A6F-717F3BE370DC}']

    function BeginTransaction: IDPOTransaction;
    procedure Commit;
    procedure Rollback;
  end;

  IDPODriverFactory = interface
    ['{EB04860D-91B2-41EA-9116-3438EBFF8C1B}']

    function CreateConnection(AConnectionName: string): TFDConnection;
    function CreateTransaction: IDPOTransaction;
    function CreateQuery: IDPOQuery;
  end;

  IConnectionConfig = interface
    ['{9DBFB013-66F5-4320-9190-233E966F4E06}']

    function getParamsConnection: String;
    function getDriverName: TDriverName;
    function getConnectionName: String;
  end;

implementation

end.
