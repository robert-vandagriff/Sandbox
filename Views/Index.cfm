
<!doctype html>
<html>
    <head>
        <title>All Star Review</title>
    </head>
    <body>
        <div class="container">
            <cfinclude template="/Includes/Navigation.cfm">
            <h1>All Star Review</h1>
            <div >
                <cfform action="SearchResults.cfm" method="post">
                    <p>
                        <span>
                            <cfinput type="Text" name="ProductSearch" size="50" maxlength="60" required="no" validate="regex" pattern="^[a-zA-Z0-9]{4,10}$">
                            <cfinput type="Submit" name="SubmitForm" value="Submit">
                        </span>
                        <span class="errorMessage">
                            <cfif isInvalid("Form.ProductSearch") AND Form.ProductSearch is not "">Error: Search may not contain special characters.</cfif>
                        </span>
                    </p>
                </cfform>
            </div>
            <cfinclude template="SearchResults.cfm">
        </div>
    </body>
</html>