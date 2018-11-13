create or replace package plUnit authid current_user as

assertion_failure exception;
pragma exception_init (assertion_failure, -20999);

function get_version return number;
function get_call_stack return varchar2;
procedure get_test_result(test_name_out out varchar2,
                          result_out out boolean,
                          error_message_out out varchar2,
                          call_stack_out out varchar2);

procedure set_test_name(test_name_in in varchar2);

procedure get_all_tests(owner in out varchar2, 
                        package_name in out varchar2, 
                        test_names_out out varchar2,
                        has_setup out boolean,
                        has_teardown out boolean);

procedure add_suite(owner in varchar2, package_name in varchar2);

procedure get_suites_from_package(owner in out varchar2, 
                                  package_name in out varchar2, 
                                  owner_names_out out varchar2,
                                  package_names_out out varchar2);

procedure call_test(owner in out varchar2, 
                    package_name in out varchar2, 
                    test_name_in in varchar2,
                    has_setup in boolean,
                    has_teardown in boolean);
                    
function run_all_tests(owner in varchar2, package_name in varchar2, show_output in boolean default true) return boolean;
procedure run_all_tests(owner in varchar2, package_name in varchar2, show_output in boolean default true);

/* assertion routines */
procedure fail(message in varchar2 default '');
procedure assert_true(condition in boolean, message in varchar2 default '');
procedure assert_false(condition in boolean, message in varchar2 default '');

procedure assert_equals(expected in varchar2, actual in varchar2, message in varchar2 default '');
procedure assert_equals(expected in boolean, actual in boolean, message in varchar2 default '');
procedure assert_equals(expected in date, actual in date, message in varchar2 default '');
procedure assert_equals(expected in number, actual in number, message in varchar2 default '');
procedure assert_equals(expected in number, actual in number, range in number, message in varchar2 default '');
--procedure assert_equals_numeric(expected in number, actual in number, range in number, message in varchar2 default '');

procedure assert_not_equals(expected in varchar2, actual in varchar2, message in varchar2 default '');
procedure assert_not_equals(expected in boolean, actual in boolean, message in varchar2 default '');
procedure assert_not_equals(expected in date, actual in date, message in varchar2 default '');
procedure assert_not_equals(expected in number, actual in number, message in varchar2 default '');
procedure assert_not_equals(expected in number, actual in number, range in number, message in varchar2 default '');
--procedure assert_not_equals_numeric(expected in number, actual in number, range in number, message in varchar2 default '');

procedure assert_null(actual in varchar2, message in varchar2 default '');
procedure assert_null(actual in date, message in varchar2 default '');
procedure assert_null(actual in boolean, message in varchar2 default '');

procedure assert_not_null(actual in varchar2, message in varchar2 default '');
procedure assert_not_null(actual in boolean, message in varchar2 default '');

procedure assert_object_exists(owner_in in varchar2, object_name_in in varchar2, object_type_in in varchar2, message in varchar2 default '');
procedure assert_object_not_exists(owner_in in varchar2, object_name_in in varchar2, object_type_in in varchar2, message in varchar2 default '');

-- assert that the results of the query in expected matches the results of the query in actual
procedure assert_query_equals(expected in varchar2, actual in varchar2, message in varchar2 default '');

-- assert that the results of the query in expected does not match the results of the query in actual
procedure assert_query_not_equals(expected in varchar2, actual in varchar2, message in varchar2 default '');

-- assert that the results of the query in query matches the value of expected
procedure assert_query_equals_value(query in varchar2, expected in varchar2, message in varchar2 default '');
procedure assert_query_equals_value(query in varchar2, expected in date, message in varchar2 default '');
procedure assert_query_equals_value(query in varchar2, expected in number, message in varchar2 default '');
procedure assert_query_equals_value(query in varchar2, expected in number, range in number, message in varchar2 default '');

-- assert that the results of the query in query does not match the value of expected
procedure assert_query_not_equals_value(query in varchar2, expected in varchar2, message in varchar2 default '');
procedure assert_query_not_equals_value(query in varchar2, expected in date, message in varchar2 default '');
procedure assert_query_not_equals_value(query in varchar2, expected in number, message in varchar2 default '');
procedure assert_query_not_equals_value(query in varchar2, expected in number, range in number, message in varchar2 default '');

-- assert that the pl/sql block passed in raises a numeric exception
procedure assert_raises_exception(plsql_call in varchar2, expected in number, message in varchar2 default '');

-- assert that the pl/sql block passed in raises a named exception
procedure assert_raises_exception(plsql_call in varchar2, expected in varchar2, message in varchar2 default '');

end;