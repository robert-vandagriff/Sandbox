<cfquery name="getProductsByName" datasource="TBD">
    SELECT  p.ProductId,
            p.ProductName,
            p.ProductNumber,
            p.ProductDescription
            FROM Products
            WHERE p.ProductName LIKE '%#Form.ProductName#%'
</cfquery>
<cfquery name="getProductAvgRating" datasource="TBD">
    SELECT  ROUND(AVG(pc.Rating),1) 
            FROM ProductComments as pc
            GROUP BY pc.ProductId
            WHERE pc.ProductId = '#Form.ProductId#'
</cfquery>
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
<!--Search Output-->
<div class="searchResults" 
    <cfif (getProductsByName.recordCount > 0)>
        style="display:block;"
    </cfif>
> 
    <!--Detail Page Search-->
    <form name="detailSearchForm" method="post" action="ProductDetails.cfm">
        <input type="hidden" name="ProductId" id="detailProductId" />
    </form>
    <!--Search Subheading-->
    <span class="searchMetaSubtitle">Showing results for "#Form.ProductSearch#"</span>
    <table>
    <th>
        <td>Name</td>
        <td>Number</td>
        <td>Description</td>
        <td>Rating</td>
    </th>     
        <cfoutput query="getProductsByName" 
        startrow="#startRow#"
        maxrows="#maxRows#">
        <!--Search Result Display Format-->
            <tr>
                <td>
                    <a href="#" onClick="Document.detailSearchForm.fnSubmit();">#ProductName#</a>
                </td>
                <td>#ProductNumber#</td>
                <td>
                    <cfif (#ProductDescription# is null) or (#ProductDescription# = "")>
                        No Description Found
                    <cfelse>
                        #ProductDescription#
                    </cfif></td>
                <td>
                    <cfoutput query="getProductAvgRating"> 
                    <cfif (#Rating# > 0) or isDefined(#Rating#)>
                            #Rating#
                            </form>
                    <cfelse>
                            No Ratings Found
                    </cfif>
                    </cfoutput>
                </td>
            </tr>
        </cfoutput>
    </table>        
</div>
<!--End Search Results -->
<script>
    function fnSubmit(var id){
        if (!id.parseInt()) {
            document.getElementById("detailProductId").value = id.parseInt();
            document.detailSearchForm.submit();
        }
        else
        {
             document.getElementByClass("errorMessage").value = "No ProductId found or ProductId invalid.";
        }
    }
</script>
