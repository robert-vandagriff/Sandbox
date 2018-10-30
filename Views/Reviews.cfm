<cfquery name="addNewReview" datasource="TBD">
    --Should check for existing review and prompt to replace
    INSERT INTO ProductReviews 
    (ProductId,ReviewerName,ReviewerComment,ReviewRating,ReviewDate)
    VALUES
    (#Form.ProductId#,#Form.ReviewerName#,#ReviewerComment#,#Form.ReviewRating#,DateTime.Now())  
</cfquery>
<cfquery name="getProductReviews" datasource="TBD">
SELECT TOP (5)  ReviewId,
                ReviewerName,
                ReviewRating,
                Convert(string,ReviewDate,1) as ReviewDateStr,
                ReviewComment
                FROM ProductReviews 
                WHERE ProductId = '#Form.ProductId#'
</cfquery>
<!--Paginate Reviews-->
<cfparam name="page" default="1">
<cfset maxRows = 10>
<cfset startRow = min( ( page-1 ) * maxRows+1, max( getProductReviews.recordCount,1 ) )>
<cfset endRow = min( startRow + maxRows-1, getProductReviews.recordCount )>
<cfset totalPages = ceiling( getProductReviews.recordCount/maxRows )>
<cfset loopercount = round( getProductReviews.recordCount/10 )>
<cfoutput>
    <cfloop from="1" to="#looperCount#" index="i">
            <a href="?page=#i#">#i#</a>
    </cfloop>
</cfoutput> 
<!-- User Reviews -->
<cfif (getProductsByName.recordCount = 0)>
    <div>
        <span>Be the first to leave a review for this product!</span>
    </div>
</cfif>
<div class="ReviewsContainer" 
    <cfif (getProductsByName.recordCount > 0)>
        style="display:block;"
    </cfif>
>
    <cfoutput query="getProductReviews" 
        startrow="#startRow#"
        maxrows="#maxRows#">>
        <div class="item-review">
            <span class="item-review-meta"><i>#ReviewerName#<b></b> said on #ReviewDateStr#</i></span>
            <span><img src="../Content/Images/"#ReviewRating#"reviewstars.png" /></span>
            <span>#ReviewComment#</span>
        </div>
    </cfouput>
</div>
<!-- End User Reviews -->