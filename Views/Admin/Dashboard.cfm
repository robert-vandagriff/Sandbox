<cfquery name="adminGetAllProducts">
    SELECT  ProductId,
            ProductName,
            ProductNumber,
            ProductDescription
</cfquery>
<cfargument name="ProductId" type="numeric" required="true"> 
<!doctype html>
<html>
    <head>
        <title>All Star Review - Dashboard</title>
    </head>
    <body>
        <div class="container">
            <cfinclude template="/Includes/Navigation.cfm">
            <!--Heading Section-->
            <div class="ItemHeader">
                <span>
                    <h1>All Star Review Dashboard</h1>
                </span>
                <!--Add New Product Button-->
                <button type="submit" value="ProjectCUD.cfm?Action=create&ProductId=0" class="adminNewProductBtn"/>
            </div>
            <!--Dashboard-->
            <!--Paginate-->
            <cfparam name="page" default="1">
            <cfset maxRows = 10>
            <cfset startRow = min( ( page-1 ) * maxRows+1, max( getProductsByName.recordCount,1 ) )>
            <cfset endRow = min( startRow + maxRows-1, getProductsByName.recordCount )>
            <cfset totalPages = ceiling( getProductsByName.recordCount/maxRows )>
            <cfset loopercount = round( getProductsByName.recordCount/10 )>
            <cfoutput>
                <cfloop from="1" to="#looperCount#" index="i">
                        <a href="?page=#i#">#i#</a>
                </cfloop>
            </cfoutput> 
            <div class="dashboardContainer">
                <table>
                    <th>
                        <td>Name</td>
                        <td>Product Number</td>
                        <td>Description</td>
                        <td>Rating</td>
                        <td># of Reviews</td>
                        <td>Actions</td>
                    </th>     
                    <cfoutput query="adminGetAllProducts"
                                startrow="#startRow#"
                                maxrows="#maxRows#">>
                    <tr>
                        <td>
                            #ProductName#
                        </td>
                        <td>
                            #ProductNumber#
                        </td>
                        <td>
                            #ProductDescription#
                        </td>
                            <!-- Get Average Rating for Product --> 
                            <cffunction name="GetAvgRating">
                                <cfargument name="ProductId" type="numeric" returntype="numeric" default="0"/>
                                <cfquery name="getProductAvgRating" datasource="TBD">
                                    SELECT  ROUND(AVG(Rating)) as AvgRating                                          
                                            FROM ProductComments
                                            GROUP BY ProductId
                                            WHERE ProductId = '#ProductId#'
                                </cfquery>
                                <cfreturn getProductAvgRating.AvgRating>
                            </cffunction>
                            <cfoutput query="getProductAvgRating">
                                <td>
                                    <img src= "../Content/Images/"#AvgRating#"reviewstars.png" class="ratingStars-total" id="averageTotalReviewStars"/>
                                </td>
                            </cfoutput>
                            <!-- Get Total Reviews for Product -->
                            <cffunction name="GetTotalReviews">
                                <cfargument name="ProductId" type="numeric" returntype="numeric" default="0"/>
                                <cfquery name="getProductAvgRating" datasource="TBD">
                                    SELECT  COUNT(ProductId) as TotalReviews,
                                            ProductId                                          
                                            FROM ProductComments
                                            GROUP BY ProductId
                                            WHERE ProductId = '#ProductId#'
                                </cfquery>
                                <cfreturn getProductAvgRating.TotalReviews>
                            </cffunction>
                            <cfoutput query="getTotalReviews">
                                <td>
                                    <!-- Not defined in documentation : Intent is to link to a search for only these reviews -->
                                    <a href="ProductDetails.cfm?ProductId=#ProductId#">#TotalReviews#</a>
                                </td>
                            <cfoutput>
                            <!--Actions-->
                            <td>
                                <span>
                                <!--Delete-->
                                <a href="javascript:fn_Delete(#ProductId#)"><img src="../../Content/Images/delete.png" /></a>
                                <!--Edit-->
                                <a href="ProjectCUD.cfm?Action=edit&ProductId=#ProductId#"><img src="../../Content/Images/edit.png" /></a>        
                                </span>
                            </td>
                    </tr>
                    </cfoutput>
                </table>
            </div>
            <div class="modalContainer">
                <cfinclude template="ProductCUD.cfm">
            </div>
        </div>
        <script>
            function fn_Delete(var id){
                if(confirm('Are you sure you want to delete this product?')){
                    window.location='ProjectCUD.cfm?Action=delete&ProductId=' + id;       
                }
                else{}
            }
        </script>
    </body>
</html>

