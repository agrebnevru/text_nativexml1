unit Native;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NativeXML;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Edit3: TEdit;
    Memo1: TMemo;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ParseXML;
  end;

var
  Form3: TForm3;
  XMLDoc: TNativeXml; //объект XML-документа
  NodeList: TXmlNodeList;//список узлов

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
ParseXML;
end;

procedure TForm3.ComboBox1Change(Sender: TObject);
var Category: TXMLNodeList;
    i:integer;
begin
Memo1.Clear;
Edit3.Text:='';
  with NodeList.Items[ComboBox1.ItemIndex] do
    begin
      Category:=TXmlNodeList.Create;
      Edit3.Text:=NodeByName('date').ValueAsString;
      Edit1.Text:=NodeByName('title').ValueAsString;
      Memo1.Text:=NodeByName('teaser').ValueAsString;
      //NodesByName('teaser',Category);
      //for I := 0 to Category.Count - 1 do
      //   Edit2.Text:=Edit2.Text+Category.Items[i].NodeByElementType(xeCData).ValueAsString+', ';
    end;
end;

procedure TForm3.ParseXML;
var i:integer;
begin
  XMLDoc:=TNativeXml.Create;//создаем экземпляр класса
  XMLDoc.LoadFromFile('api.xml');//загружаем данные из потока
  if XMLDoc.IsEmpty then
    raise Exception.Create('Пустой XML! Работа прервана!');
  NodeList:=TXmlNodeList.Create;
  XMLDoc.Root.FindNodes('item',NodeList);//получаем список узлов Item
  label4.Caption:=IntToStr(NodeList.Count);
  {парсим каждый узел Item}
  ComboBox1.Items.Clear;
  for I := 0 to NodeList.Count - 1 do
     ComboBox1.Items.Add(NodeList.Items[i].NodeByName('title').ValueAsString);
end;

end.
