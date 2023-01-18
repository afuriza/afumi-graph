unit ControlFindSquig;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  opensslsockets, fphttpclient, jsparser, fpjson, httpprotocol, FileUtil;

type

  { TfrmFindSquig }

  TfrmFindSquig = class(TForm)
    Button1: TButton;
    edPrev: TEdit;
    ProductList: TListBox;
    SquiglyList: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ProductListClick(Sender: TObject);
    procedure SquiglyListClick(Sender: TObject);
  private
    CurrentSqugly: string;
  public
    SquiglyJSON: TJSONArray;
    ProductJSON: TJSONArray;
  end;

var
  frmFindSquig: TfrmFindSquig;

implementation
uses
  ControlMain;

{$R *.lfm}

{ TfrmFindSquig }

procedure TfrmFindSquig.FormShow(Sender: TObject);
var
  Client: TFPHTTPClient;
  i: Integer;
begin
  Client := TFPHTTPClient.Create(nil);
  try
    SquiglyJSON := TJSONArray(GetJSON(Client.Get('https://squig.link/squigsites.json')));
    SquiglyList.Clear;
    for i := 0 to SquiglyJSON.Count -1 do
    begin
      //if SquiglyJSON[i].FindPath('dbs').Count < 2 then
      SquiglyList.Items.Add(SquiglyJSON[i].FindPath('name').AsString + ' (' +
        SquiglyJSON[i].FindPath('username').AsString + ')'
        );
    end;
  finally
    Client.Free;
  end;
end;

procedure TfrmFindSquig.ProductListClick(Sender: TObject);
begin
  if ProductList.ItemIndex <> -1 then
  begin
    if CurrentSqugly.Contains('superreview') then
      edPrev.Text := 'https://squig.link/data_mrs/'+
        EncodeURLElement(ProductList.Items[ProductList.ItemIndex]+' L')+
        '.txt'
    else
      edPrev.Text := 'https://'+CurrentSqugly +
        '.squig.link/data/'+EncodeURLElement(ProductList.Items[ProductList.ItemIndex]+' L')+
        '.txt';
  end;
end;

procedure TfrmFindSquig.Button1Click(Sender: TObject);
var
  SquiglyURL: String;
  Client: TFPHTTPClient;
begin
  if ProductList.ItemIndex <> -1 then
  begin
    //if CurrentSqugly.Contains('superreview') then
    //  SquiglyURL := 'https://squig.link/data/'+
    //    EncodeURLElement(ProductList.Items[ProductList.ItemIndex]+' L')+
    //    '.txt'
    //else
    //  SquiglyURL := 'https://'+CurrentSqugly +
    //    '.squig.link/data/'+EncodeURLElement(ProductList.Items[ProductList.ItemIndex]+' L')+
    //    '.txt';
    SquiglyURL := edPrev.Text;
    Client := TFPHTTPClient.Create(nil);
    try
      frmMain.ParseText(Client.Get(SquiglyURL),
        ExtractFileNameWithoutExt(ExtractFileName(DecodeURLElement(SquiglyURL))), CurrentSqugly);
      Close;
    finally
      Client.Free;

    end;
  end
  else
  begin
    ShowMessage('Select a product item!');
  end;
end;

procedure TfrmFindSquig.SquiglyListClick(Sender: TObject);
var
  SquiglyURL: String;
  Client: TFPHTTPClient;
  i,j,k: Integer;
begin
  if SquiglyList.ItemIndex <> -1 then
  begin
    ProductList.Clear;
    CurrentSqugly := SquiglyJSON[SquiglyList.ItemIndex].FindPath('username').AsString;
    if CurrentSqugly.Contains('superreview') then
      SquiglyURL := 'https://squig.link/data_mrs/phone_book.json'
    else
      SquiglyURL := 'https://'+CurrentSqugly +
        '.squig.link/data/phone_book.json';
    Client := TFPHTTPClient.Create(nil);
    try
      ProductJSON := TJSONArray(GetJSON(Client.Get(SquiglyURL)));
      for i := 0 to ProductJSON.Count -1 do
      begin
        for j := 0 to TJSONArray(ProductJSON[i].FindPath('phones')).Count -1 do
        begin
          if TJSONArray(ProductJSON[i].FindPath('phones'))[j].FindPath('file').JSONType =
              jtArray then
          begin
            for k := 0 to TJSONArray(TJSONArray(ProductJSON[i].FindPath('phones'))[j]
              .FindPath('file')).Count -1 do
            begin

                ProductList.Items.Add(TJSONArray(TJSONArray(ProductJSON[i].FindPath('phones'))[j]
                .FindPath('file'))[k].AsString);

            end;
          end
          else if TJSONArray(ProductJSON[i].FindPath('phones'))[j].FindPath('file').JSONType =
            jtString then
          begin
            ProductList.Items.Add(TJSONArray(ProductJSON[i].FindPath('phones'))[j]
            .FindPath('file').AsString)
          end;
        end;
      end;
    finally
      Client.Free;
    end;

  end;
end;

end.

