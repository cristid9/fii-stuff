/*
   Afisati la intamplare un user diferit de admin care a trecut laboratorul. Are 
   minim 10 intrebari... Adica afisati usernameul. De asemenea, sa se afiseze si
   cate intrebari a postat el.
 */

set serveroutput on;

declare 
    v_username users.username%type;
    v_m_intrebari int;
    v_reporturi int;
    v_name users.name%type;

begin
    SELECT username 
    INTO v_username FROM
    (SELECT username from users u join questions q on u.id = q.user_id
     WHERE user_role <> 'admin'
     GROUP BY username
     HAVING count(q.id) >= 10
     ORDER BY dbms_random.value)
    WHERE rownum = 1;

    SELECT COUNT(q.id)
    INTO v_m_intrebari
    FROM QUESTIONS q JOIN users u on q.user_id = u.id
    WHERE username = v_username;

    dbms_output.put_line
    ( 'user ' || v_username ||
      ' a pus ' || v_m_intrebari ||
      ' intrebari');
 end;
