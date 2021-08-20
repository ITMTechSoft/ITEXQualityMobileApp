

class LanguagesBLL {
  //#region Properties
  int Id;
  String? CultureName;
  String? EnglishName;
  bool? IsRtl;
  String? NativeName;

  //#endregion

  LanguagesBLL(this.Id, this.CultureName);

  //#region Json Mapping
  LoadFromJson(Map<String, dynamic> json) {
    this.Id = json['Id'];
    this.CultureName = json['CultureName'];
    this.EnglishName = json['EnglishName'];
    this.IsRtl = json['IsRtl'];
    this.NativeName = json['NativeName'];
  }

  LanguagesBLL.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        CultureName = json['CultureName'],
        EnglishName = json['EnglishName'],
        IsRtl = json['IsRtl'],
        NativeName = json['NativeName'];

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'CultureName': CultureName,
        'EnglishName': EnglishName,
        'IsRtl': IsRtl,
        'NativeName': NativeName,
      };

  Map<String, String> toPost() => {
        'Id': Id.toString(),
        'CultureName': CultureName??'',
        'EnglishName': EnglishName??'',
        'IsRtl': IsRtl.toString(),
        'NativeName': NativeName??'',
      };

  //#endregion

  //#region GetWebApiUrl
  static List<LanguagesBLL> Get_Languages() {
    List<LanguagesBLL> ItemList = new List<LanguagesBLL>();
    ItemList.add(new LanguagesBLL(1, "Türkçe"));
    ItemList.add(new LanguagesBLL(2, "English"));
    return ItemList;
  }
//#endregion

}
