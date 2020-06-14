drop table if exists group_post_comments
drop table if exists user_post_comments
drop table if exists group_posts;
drop table if exists user_posts;
drop table if exists group_members;
drop table if exists groups;
drop table if exists user_information;
drop table if exists users;

create tables users(
    user_id serial primary key,
    username varchr(500),
    password varchar(500)
);

create table user_information(
    user_id integer references users(user_id)
    first_name varchar(100),
    last_name varchar(100),
    profile_pic varchar(1000),
    birthday date
);

-- one to one relationship, one user = one profile

create table groups(
    group_id serial primary key
    name varchar(100),
    description varchar(3000),
    organizer integer references users(user_id),
    creation_date date
);

select u.user_id, g.group_id, g.creation_date
into group_members
from users u
join groups g on u.user_id = g.group_id;

create table user_posts(
    id serial primary key,
    user_id integer references users(user_id),
    title varchar(100),
    text varchar(3000),
    date date,
);

-- one to many, one user = many posts

create table group_posts(
    id serial primary key,
    group_id integer references groups(group_id),
    title varchar(100),
    text varchar(3000),
    date date,
);

-- one to many, one group = many posts

create table user_post_comments(
    id serial primary key,
    user_id integer references users(user_id),
    post_id integer references user_posts(id),
    title varchar(100),
    text varchar(3000),
    date date
);

create table group_post_comments(
    id serial primary key,
    user_id integer references users(user_id),
    post_id integer references group_posts(id),
    title varchar(100),
    text varchar(3000),
    date date
)

-- many to many, many users = many comments & many groups = many comments

create table friends(
    user_id integer references user(user_id),
    friend_id integer references users(user_id),
    accepted boolean
);