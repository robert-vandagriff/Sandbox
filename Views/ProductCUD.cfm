<cfparam name="Action" type="[string]" default="[]">
<cfquery name="DeleteProduct" datasource="TBD">
    IF #Form.Action# = "delete"
        DELETE FROM Products as p LEFT JOIN ProductReviews as pr
            ON p.ProductId = pr.ProductId
            WHERE p.ProductId = '#Form.ProductId#'
    ELSE
        --Take No Action
</cfquery>
<cfquery name="GetProductCategories" datasource="TBD">
    Select  CategoryId,
            DISTINCT CategoryName
            FROM ProductCategories
            GROUP BY CategoryName
</cfquery>
<!--Add/Edit Product Form Modal Controls-->
<div class="productCudForm" id="cudProductModal">
    <cfform method="put" action="UpdateProduct.cfm">
        <cfinput type="hidden" name="ProductId" value="#Form.ProductId#">
        <label>Product Name</label>
        <cfinput type="Text" name="ProductName" size="50" maxlength="60" required="yes" validate="regex" pattern="^[a-zA-Z0-9]{4,10}$"
        <cfif #Form.Action# = "Edit">
            value = "#Form.ProductName#"
        </cfif>
        >
        <label>Product Description</label>
        <cfinput type="Text" name="ProductDescription" size="50" maxlength="60" required="yes" validate="regex" pattern="^[a-zA-Z0-9]{4,10}$"
        <cfif #Form.Action# = "Edit">
            value = "#Form.ProductDescription#"
        </cfif>
        >
        <label>Product Number</label>
        <cfinput type="Text" name="ProductNumber" size="50" maxlength="60" required="yes" validate="regex" pattern="^[a-zA-Z0-9-]{4,10}$"
        <cfif #Form.Action# = "Edit">
            value = "#Form.ProductNumber#"
        </cfif>
        >
        <cfselect name="ProductCategory"
        <cfif #Form.Action# = "Edit">
            selected = "#Form.CategoryId#"
        </cfif>
        >
            <cfouput>
                <option value="#GetProductCategories.CategoryId#">#GetProductCategories.CategoryName#</option>
            </cfoutput>
        </cfselect>
        <label>Standard Cost</label>
        <cfinput type="Text" name="ProductStandardCost" size="50" maxlength="60" required="yes" validate="regex" pattern="^[a-zA-Z0-9-$.]{4,10}$"
        <cfif #Form.Action# = "Edit">
            selected = "#Form.ProductStandardCost#"
        </cfif>
        >
        <span class="modalControls">
            <cfinput type="Submit" name="SubmitForm" 
            <cfif #Form.Action# is "Add">
            value="Add"
            <cfelse #Form.Action# is "Save">
            value="Edit"
            </cfif>
            >
            <button type="submit" value="close" onclick="javascript:close_modal(this);">
        </span>
    </cfform> 
</div>
<!--Add/Edit Product Confirmation-->
<cfinclude template="UpdateProduct.cfm">
<!--Delete Product Confirmation-->
<div id="deleteConfirmationMsg">
    <h3>Product : #Form.ProductName# (#Form.ProductNumber#) and associated reviews have been successfully deleted.</h3>
</div>
<!--scripts for CUD modal-->
<script>
    var id = '#Form.ProductId#';
    var action = '#Form.Action#';  
    
    function open_modal() {
        if ((action = "Add") || (action="Edit")){
            var Modal = document.getElementById('cudProductModal');
            Modal.style.display = "block";
        }
        else{
            if(action = "Delete"){
                var msg = document.getElementById('deleteConfirmationMsg');
                msg..style.display = "block";
            }
        }
    }

    function close_modal(callingElement) {
        var id = callingElement.parentNode.id;
        document.getElementById(id).style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>