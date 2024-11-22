:- use_module(library(csv)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_server)).

% Helper: Add CORS headers to response
add_cors_headers :-
    format('Access-Control-Allow-Origin: *~n'),
    format('Access-Control-Allow-Methods: GET, POST, OPTIONS~n'),
    format('Access-Control-Allow-Headers: Content-Type~n').

% Load data from CSV and assert facts
load_csv_data :-
    csv_read_file("data.csv", Rows, [functor(student), arity(4)]),
    maplist(assert, Rows).

:- initialization(load_csv_data).

% Rules for scholarship and exam permission
eligible_for_scholarship(Student_ID) :-
    student(Student_ID, _, Attendance_Percentage, CGPA),
    Attendance_Percentage >= 75,
    CGPA >= 9.0.

permitted_for_exam(Student_ID) :-
    student(Student_ID, _, Attendance_Percentage, _),
    Attendance_Percentage >= 75.

% REST API Endpoints
:- http_handler('/check_scholarship', handle_scholarship, []).
:- http_handler('/check_exam_permission', handle_exam_permission, []).

% Start server
:- initialization(http_server(http_dispatch, [port(8080)])).

% Handle scholarship check
handle_scholarship(Request) :-
    add_cors_headers,
    http_parameters(Request, [id(Student_ID, [integer])]),
    ( eligible_for_scholarship(Student_ID)
    -> Reply = json([status="Eligible"])
    ;  Reply = json([status="Not Eligible"])
    ),
    reply_json(Reply).

% Handle exam permission check
handle_exam_permission(Request) :-
    add_cors_headers,
    http_parameters(Request, [id(Student_ID, [integer])]),
    ( permitted_for_exam(Student_ID)
    -> Reply = json([status="Permitted"])
    ;  Reply = json([status="Not Permitted"])
    ),
    reply_json(Reply).
