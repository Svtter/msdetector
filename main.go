package main

import (
	"database/sql"
	"fmt"
	"net/url"

	_ "github.com/denisenkom/go-mssqldb"
)

func main() {
	query := url.Values{}
	query.Add("app name", "MyAppName")

	u := &url.URL{
		Scheme: "sqlserver",
		User:   url.UserPassword("sa", "password"),
		Host:   fmt.Sprintf("%s:%d", "db", "1433"),
		// Path:  instance, // if connecting to an instance instead of a port
		RawQuery: query.Encode(),
	}
	db, err := sql.Open("sqlserver", u.String())
	if err != nil {
		panic(err)
	}

	fmt.Println(db)
}
