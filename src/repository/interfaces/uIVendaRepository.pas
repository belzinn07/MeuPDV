unit uIVendaRepository;

interface

uses
  uVenda, uItemVenda, System.Generics.Collections;

type
 IVendaRepository = interface
   ['{F219FBF0-5374-4D17-ADE6-AA28F9B75F82}']

  procedure SalvarVendaComItens(AVenda: TVenda; AItens: TObjectList<TItemVenda>);

 end;

implementation

end.