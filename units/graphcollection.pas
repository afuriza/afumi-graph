unit GraphCollection;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fgl, TASeries, ComCtrls;

type
  TProduct = class(TObject)
    author_alias: string;
    author_name: string;
    product_name: string;
    graph_series: TLineSeries;
    graph_listitem: TListItem;
    graph_data: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TProducts = specialize TFPGObjectList<TProduct>;

implementation

constructor TProduct.Create;
begin
  graph_data := TStringList.Create;
end;

destructor TProduct.Destroy;
begin
  FreeAndNil(graph_data);
end;

end.

