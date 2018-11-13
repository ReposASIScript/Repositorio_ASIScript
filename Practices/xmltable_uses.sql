create table users (id number, profile xmltype);

insert into users values (1, XMLTYPE('<profile>
        <subject>I
           <action>like
               <object>sports</object>
               <object>music</object>
           </action>
        </subject>
    </profile>'));

select u.id, x.action, y.object
  from users u, XMLTABLE('/profile/subject/action'
                         passing u.profile
                         columns action VARCHAR2(30) PATH 'text()',
                                 object XMLTYPE PATH 'object') x,
                XMLTABLE('/object'
                         passing x.object
                         columns object VARCHAR2(30) PATH '.') y;