class Notes {
  String title;
  String text;

  Notes(this.text,this.title);
 
  Notes.fromjson(Map<String,dynamic> json){
    title=json['title'];
    text=json['body'];

  }
  
}