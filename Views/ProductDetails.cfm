<cfquery name="getProductById" datasource="TBD">
    SELECT  p.ProductId,
            p.ProductName,
            p.ProductNumber,
            c.CategoryName,
            p.ProductDescription,
            p.ProductSalePrice
            FROM Products as P LEFT JOIN ProductCategories as pc
                ON p.ProductCategory = pc.CategoryId
            WHERE p.ProductId LIKE '%#Form.ProductId#%'
</cfquery>
<cfquery name="getProductAvgRating" datasource="TBD">
    SELECT  ROUND(AVG(pc.ReviewRating)) as AvgRating
            FROM ProductComments
            GROUP BY ProductId
            WHERE ProductId = '#Form.ProductId#'
</cfquery>
<!doctype html>
<html>
    <head>
        <title>All Star Review</title>
    </head>
    <body>
        <div class="container">
            <cfinclude template="/Includes/Navigation.cfm">
            <cfouput query="getProductById">
                <!--Heading Section-->
                <div class="itemHeader">
                    <span>
                        <h1>#ProductName#</h1>
                        <cfouput query="getProductAvgRating">
                            <img src= "../Content/Images/"#AvgRating#"reviewstars.png" class="ratingStars-total" id="averageTotalReviewStars"/>
                        </cfoutput>
                    </span>
                </div>
                <!--Details-->
                <div class="itemDetailContainer">
                    <div class="detailPanel-Left">
                        <span class="details-subheader">Description:</span>
                        <p>#ProductDescription#</p>
                        <span class="details-subheader">Product Number:</span>
                        <p>#ProductNumber#</p>
                        <span class="details-subheader">Product Category:</span>
                        <p>#ProductCategory#</p>
                        <span class="details-subheader">Price:</span>
                        <p>#ProductSalePrice#</p>                       
                    </div>    
                    <div class="detailPanel-Right">
                        <!--Feedback Form-->
                        <div class="feedbackForm">
                            <h2>Product Reviews</h2>
                            <cfform name="feedbackForm" method="post" action="Reviews.cfm">
                                <label>Your Name:</label>
                                <cfinput type="Text" name="ReviewerName" size="30" maxlength="40" 
                                    value="Enter your name..." required="yes" validate="regex" pattern="^[a-zA-Z0-9]{4,10}$">
                                <label>Your Feedback:</label>
                                <cfinput type="TextArea" name="ReviewerComment" size="30" maxlength="60" 
                                    value="Enter your comment..." required="yes" validate="regex" pattern="^[a-zA-Z0-9]{4,10}$">
                                <cfinput></cfinput>
                                <label>Your Rating:</label>                               
                                <cfselect name="Rating" required="yes" value="" size="5" value="ReviewRating" multiple="no" selected="5">
                                    <cfloop ratings = "index"
                                            from = "5"
                                            to = "0"
                                            step = "-1">
                                        <option value="#index#">#index#</option>
                                    </cfloop>
                                </cselect>
                                <cfinput type="Submit" name="SubmitForm" value="Save">
                            </cfform>
                        </div>
                    </div>   
                </div>
            </cfoutput>
            <!-- User Reviews -->
            <cfinclude template="Reviews.cfm">
    </body>
</html>