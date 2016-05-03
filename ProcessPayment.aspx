<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ProcessPayment.aspx.cs" Inherits="Payment" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
    <form runat="server">
        <div class="form-horizontal" role="form">
        <input type="hidden" name="withDelivery" />

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Cart Details</h3>
            </div>
            <div class="panel-body">
                <p><%=ReturnItemDesc() %></p>
                <p>Total: <%=ReturnCartTotal().ToString("N") %></p>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">
                  <i class="fa fa-info-circle"></i> Please note Credit Card payments will have a 2 percent(%) handling fee applied</h3>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <asp:Label ID="LblCardType" runat="server" CssClass="col-sm-2 control-label" ControlName="DdlCardType" Text="Card Type:"></asp:Label>
                    <div class="col-sm-4">
                        <asp:DropDownList ID="paymentType" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="paymentType_SelectedIndexChanged">
                            <asp:ListItem Value="VISA">VISA</asp:ListItem>
                            <asp:ListItem Value="MSCD">MASTERCARD</asp:ListItem>
                            <asp:ListItem Value="DMC">MASTERCARD DEBIT</asp:ListItem>
                            <asp:ListItem Value="MAES">MAESTRO</asp:ListItem>
                            <asp:ListItem Value="VISD">VISA DELTA</asp:ListItem>
                            <asp:ListItem Value="VIED">VISA ELECTRON</asp:ListItem>
                            <asp:ListItem Value="JCB">JCB</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal-header">Billing Address</div>
        <div class="well">
            <div class="form-group">
                <asp:Label ID="LblCustomerName" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtCustomerName" Text="Name:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtCustomerName" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCustomerName" runat="server" ErrorMessage="Name is required"
                        ControlToValidate="TxtCustomerName" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LblAddress1" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtAddress1" Text="Address 1:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtAddress1" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAddress1" runat="server" ErrorMessage="Address 1 is required"
                        ControlToValidate="TxtAddress1" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LblAddress2" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtAddress2" Text="Address 2:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtAddress2" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LblAddress3" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtAddress3" Text="Address 3:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtAddress3" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LblTown" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtTown" Text="Town:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtTown" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTown" runat="server" ErrorMessage="Town is required"
                        ControlToValidate="TxtTown" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LblRegion" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtRegion" Text="Region/County:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtRegion" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LblPostcode" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtPostcode" Text="Postcode:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtPostcode" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPostcode" runat="server" ErrorMessage="Postcode is required"
                        ControlToValidate="TxtPostcode" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LblCountry" runat="server" CssClass="col-sm-2 control-label" ControlName="DdlCountry" Text="Country:"></asp:Label>
                <div class="col-sm-4">
                    <asp:DropDownList ID="DdlCountry" CssClass="form-control" runat="server">
                        <asp:ListItem Value="GB">United Kingdom</asp:ListItem>
                        <asp:ListItem Value="US">United States</asp:ListItem>
                        <asp:ListItem Value="AL">Albania</asp:ListItem>
                        <asp:ListItem Value="DZ">Algeria</asp:ListItem>
                        <asp:ListItem Value="AS">American Samoa</asp:ListItem>
                        <asp:ListItem Value="AD">Andorra</asp:ListItem>
                        <asp:ListItem Value="AO">Angola</asp:ListItem>
                        <asp:ListItem Value="AI">Anguilla</asp:ListItem>
                        <asp:ListItem Value="AQ">Antarctica</asp:ListItem>
                        <asp:ListItem Value="AG">Antigua and Barbuda</asp:ListItem>
                        <asp:ListItem Value="AR">Argentina</asp:ListItem>
                        <asp:ListItem Value="AM">Armenia</asp:ListItem>
                        <asp:ListItem Value="AW">Aruba</asp:ListItem>
                        <asp:ListItem Value="AU">Australia</asp:ListItem>
                        <asp:ListItem Value="AT">Austria</asp:ListItem>
                        <asp:ListItem Value="AZ">Azerbaijan</asp:ListItem>
                        <asp:ListItem Value="BS">Bahamas</asp:ListItem>
                        <asp:ListItem Value="BH">Bahrain</asp:ListItem>
                        <asp:ListItem Value="BD">Bangladesh</asp:ListItem>
                        <asp:ListItem Value="BB">Barbados</asp:ListItem>
                        <asp:ListItem Value="BY">Belarus</asp:ListItem>
                        <asp:ListItem Value="BE">Belgium</asp:ListItem>
                        <asp:ListItem Value="BZ">Belize</asp:ListItem>
                        <asp:ListItem Value="BJ">Benin</asp:ListItem>
                        <asp:ListItem Value="BM">Bermuda</asp:ListItem>
                        <asp:ListItem Value="BT">Bhutan</asp:ListItem>
                        <asp:ListItem Value="BO">Bolivia</asp:ListItem>
                        <asp:ListItem Value="BA">Bosnia and Herzegovina</asp:ListItem>
                        <asp:ListItem Value="BW">Botswana</asp:ListItem>
                        <asp:ListItem Value="BV">Bouvet Island</asp:ListItem>
                        <asp:ListItem Value="BR">Brazil</asp:ListItem>
                        <asp:ListItem Value="IO">British Indian Ocean Territory</asp:ListItem>
                        <asp:ListItem Value="BN">Brunei Darussalam</asp:ListItem>
                        <asp:ListItem Value="BG">Bulgaria</asp:ListItem>
                        <asp:ListItem Value="BF">Burkina Faso</asp:ListItem>
                        <asp:ListItem Value="BI">Burundi</asp:ListItem>
                        <asp:ListItem Value="KH">Cambodia</asp:ListItem>
                        <asp:ListItem Value="CM">Cameroon</asp:ListItem>
                        <asp:ListItem Value="CA">Canada</asp:ListItem>
                        <asp:ListItem Value="CV">Cape Verde</asp:ListItem>
                        <asp:ListItem Value="KY">Cayman Islands</asp:ListItem>
                        <asp:ListItem Value="CF">Central African Republic</asp:ListItem>
                        <asp:ListItem Value="TD">Chad</asp:ListItem>
                        <asp:ListItem Value="CL">Chile</asp:ListItem>
                        <asp:ListItem Value="CN">China</asp:ListItem>
                        <asp:ListItem Value="CX">Christmas Island</asp:ListItem>
                        <asp:ListItem Value="CC">Cocos (Keeling) Islands</asp:ListItem>
                        <asp:ListItem Value="CO">Colombia</asp:ListItem>
                        <asp:ListItem Value="KM">Comoros</asp:ListItem>
                        <asp:ListItem Value="CG">Congo</asp:ListItem>
                        <asp:ListItem Value="CD">Congo, the Democratic Republic of the</asp:ListItem>
                        <asp:ListItem Value="CK">Cook Islands</asp:ListItem>
                        <asp:ListItem Value="CR">Costa Rica</asp:ListItem>
                        <asp:ListItem Value="CI">Cote D'Ivoire</asp:ListItem>
                        <asp:ListItem Value="HR">Croatia</asp:ListItem>
                        <asp:ListItem Value="CU">Cuba</asp:ListItem>
                        <asp:ListItem Value="CY">Cyprus</asp:ListItem>
                        <asp:ListItem Value="CZ">Czech Republic</asp:ListItem>
                        <asp:ListItem Value="DK">Denmark</asp:ListItem>
                        <asp:ListItem Value="DJ">Djibouti</asp:ListItem>
                        <asp:ListItem Value="DM">Dominica</asp:ListItem>
                        <asp:ListItem Value="DO">Dominican Republic</asp:ListItem>
                        <asp:ListItem Value="EC">Ecuador</asp:ListItem>
                        <asp:ListItem Value="EG">Egypt</asp:ListItem>
                        <asp:ListItem Value="SV">El Salvador</asp:ListItem>
                        <asp:ListItem Value="GQ">Equatorial Guinea</asp:ListItem>
                        <asp:ListItem Value="ER">Eritrea</asp:ListItem>
                        <asp:ListItem Value="EE">Estonia</asp:ListItem>
                        <asp:ListItem Value="ET">Ethiopia</asp:ListItem>
                        <asp:ListItem Value="FK">Falkland Islands (Malvinas)</asp:ListItem>
                        <asp:ListItem Value="FO">Faroe Islands</asp:ListItem>
                        <asp:ListItem Value="FJ">Fiji</asp:ListItem>
                        <asp:ListItem Value="FI">Finland</asp:ListItem>
                        <asp:ListItem Value="FR">France</asp:ListItem>
                        <asp:ListItem Value="GF">French Guiana</asp:ListItem>
                        <asp:ListItem Value="PF">French Polynesia</asp:ListItem>
                        <asp:ListItem Value="TF">French Southern Territories</asp:ListItem>
                        <asp:ListItem Value="GA">Gabon</asp:ListItem>
                        <asp:ListItem Value="GM">Gambia</asp:ListItem>
                        <asp:ListItem Value="GE">Georgia</asp:ListItem>
                        <asp:ListItem Value="DE">Germany</asp:ListItem>
                        <asp:ListItem Value="GH">Ghana</asp:ListItem>
                        <asp:ListItem Value="GI">Gibraltar</asp:ListItem>
                        <asp:ListItem Value="GR">Greece</asp:ListItem>
                        <asp:ListItem Value="GL">Greenland</asp:ListItem>
                        <asp:ListItem Value="GD">Grenada</asp:ListItem>
                        <asp:ListItem Value="GP">Guadeloupe</asp:ListItem>
                        <asp:ListItem Value="GU">Guam</asp:ListItem>
                        <asp:ListItem Value="GT">Guatemala</asp:ListItem>
                        <asp:ListItem Value="GN">Guinea</asp:ListItem>
                        <asp:ListItem Value="GW">Guinea-Bissau</asp:ListItem>
                        <asp:ListItem Value="GY">Guyana</asp:ListItem>
                        <asp:ListItem Value="HT">Haiti</asp:ListItem>
                        <asp:ListItem Value="HM">Heard Island and Mcdonald Islands</asp:ListItem>
                        <asp:ListItem Value="VA">Holy See (Vatican City State)</asp:ListItem>
                        <asp:ListItem Value="HN">Honduras</asp:ListItem>
                        <asp:ListItem Value="HK">Hong Kong</asp:ListItem>
                        <asp:ListItem Value="HU">Hungary</asp:ListItem>
                        <asp:ListItem Value="IS">Iceland</asp:ListItem>
                        <asp:ListItem Value="IN">India</asp:ListItem>
                        <asp:ListItem Value="ID">Indonesia</asp:ListItem>
                        <asp:ListItem Value="IR">Iran, Islamic Republic of</asp:ListItem>
                        <asp:ListItem Value="IQ">Iraq</asp:ListItem>
                        <asp:ListItem Value="IE">Ireland</asp:ListItem>
                        <asp:ListItem Value="IL">Israel</asp:ListItem>
                        <asp:ListItem Value="IT">Italy</asp:ListItem>
                        <asp:ListItem Value="JM">Jamaica</asp:ListItem>
                        <asp:ListItem Value="JP">Japan</asp:ListItem>
                        <asp:ListItem Value="JO">Jordan</asp:ListItem>
                        <asp:ListItem Value="KZ">Kazakhstan</asp:ListItem>
                        <asp:ListItem Value="KE">Kenya</asp:ListItem>
                        <asp:ListItem Value="KI">Kiribati</asp:ListItem>
                        <asp:ListItem Value="KP">Korea, Democratic People's Republic of</asp:ListItem>
                        <asp:ListItem Value="KR">Korea, Republic of</asp:ListItem>
                        <asp:ListItem Value="KW">Kuwait</asp:ListItem>
                        <asp:ListItem Value="KG">Kyrgyzstan</asp:ListItem>
                        <asp:ListItem Value="LA">Lao People's Democratic Republic</asp:ListItem>
                        <asp:ListItem Value="LV">Latvia</asp:ListItem>
                        <asp:ListItem Value="LB">Lebanon</asp:ListItem>
                        <asp:ListItem Value="LS">Lesotho</asp:ListItem>
                        <asp:ListItem Value="LR">Liberia</asp:ListItem>
                        <asp:ListItem Value="LY">Libyan Arab Jamahiriya</asp:ListItem>
                        <asp:ListItem Value="LI">Liechtenstein</asp:ListItem>
                        <asp:ListItem Value="LT">Lithuania</asp:ListItem>
                        <asp:ListItem Value="LU">Luxembourg</asp:ListItem>
                        <asp:ListItem Value="MO">Macao</asp:ListItem>
                        <asp:ListItem Value="MK">Macedonia, the Former Yugoslav Republic of</asp:ListItem>
                        <asp:ListItem Value="MG">Madagascar</asp:ListItem>
                        <asp:ListItem Value="MW">Malawi</asp:ListItem>
                        <asp:ListItem Value="MY">Malaysia</asp:ListItem>
                        <asp:ListItem Value="MV">Maldives</asp:ListItem>
                        <asp:ListItem Value="ML">Mali</asp:ListItem>
                        <asp:ListItem Value="MT">Malta</asp:ListItem>
                        <asp:ListItem Value="MH">Marshall Islands</asp:ListItem>
                        <asp:ListItem Value="MQ">Martinique</asp:ListItem>
                        <asp:ListItem Value="MR">Mauritania</asp:ListItem>
                        <asp:ListItem Value="MU">Mauritius</asp:ListItem>
                        <asp:ListItem Value="YT">Mayotte</asp:ListItem>
                        <asp:ListItem Value="MX">Mexico</asp:ListItem>
                        <asp:ListItem Value="FM">Micronesia, Federated States of</asp:ListItem>
                        <asp:ListItem Value="MD">Moldova, Republic of</asp:ListItem>
                        <asp:ListItem Value="MC">Monaco</asp:ListItem>
                        <asp:ListItem Value="MN">Mongolia</asp:ListItem>
                        <asp:ListItem Value="MS">Montserrat</asp:ListItem>
                        <asp:ListItem Value="MA">Morocco</asp:ListItem>
                        <asp:ListItem Value="MZ">Mozambique</asp:ListItem>
                        <asp:ListItem Value="MM">Myanmar</asp:ListItem>
                        <asp:ListItem Value="NA">Namibia</asp:ListItem>
                        <asp:ListItem Value="NR">Nauru</asp:ListItem>
                        <asp:ListItem Value="NP">Nepal</asp:ListItem>
                        <asp:ListItem Value="NL">Netherlands</asp:ListItem>
                        <asp:ListItem Value="AN">Netherlands Antilles</asp:ListItem>
                        <asp:ListItem Value="NC">New Caledonia</asp:ListItem>
                        <asp:ListItem Value="NZ">New Zealand</asp:ListItem>
                        <asp:ListItem Value="NI">Nicaragua</asp:ListItem>
                        <asp:ListItem Value="NE">Niger</asp:ListItem>
                        <asp:ListItem Value="NG">Nigeria</asp:ListItem>
                        <asp:ListItem Value="NU">Niue</asp:ListItem>
                        <asp:ListItem Value="NF">Norfolk Island</asp:ListItem>
                        <asp:ListItem Value="MP">Northern Mariana Islands</asp:ListItem>
                        <asp:ListItem Value="NO">Norway</asp:ListItem>
                        <asp:ListItem Value="OM">Oman</asp:ListItem>
                        <asp:ListItem Value="PK">Pakistan</asp:ListItem>
                        <asp:ListItem Value="PW">Palau</asp:ListItem>
                        <asp:ListItem Value="PS">Palestinian Territory, Occupied</asp:ListItem>
                        <asp:ListItem Value="PA">Panama</asp:ListItem>
                        <asp:ListItem Value="PG">Papua New Guinea</asp:ListItem>
                        <asp:ListItem Value="PY">Paraguay</asp:ListItem>
                        <asp:ListItem Value="PE">Peru</asp:ListItem>
                        <asp:ListItem Value="PH">Philippines</asp:ListItem>
                        <asp:ListItem Value="PN">Pitcairn</asp:ListItem>
                        <asp:ListItem Value="PL">Poland</asp:ListItem>
                        <asp:ListItem Value="PT">Portugal</asp:ListItem>
                        <asp:ListItem Value="PR">Puerto Rico</asp:ListItem>
                        <asp:ListItem Value="QA">Qatar</asp:ListItem>
                        <asp:ListItem Value="RE">Reunion</asp:ListItem>
                        <asp:ListItem Value="RO">Romania</asp:ListItem>
                        <asp:ListItem Value="RU">Russian Federation</asp:ListItem>
                        <asp:ListItem Value="RW">Rwanda</asp:ListItem>
                        <asp:ListItem Value="SH">Saint Helena</asp:ListItem>
                        <asp:ListItem Value="KN">Saint Kitts and Nevis</asp:ListItem>
                        <asp:ListItem Value="LC">Saint Lucia</asp:ListItem>
                        <asp:ListItem Value="PM">Saint Pierre and Miquelon</asp:ListItem>
                        <asp:ListItem Value="VC">Saint Vincent and the Grenadines</asp:ListItem>
                        <asp:ListItem Value="WS">Samoa</asp:ListItem>
                        <asp:ListItem Value="SM">San Marino</asp:ListItem>
                        <asp:ListItem Value="ST">Sao Tome and Principe</asp:ListItem>
                        <asp:ListItem Value="SA">Saudi Arabia</asp:ListItem>
                        <asp:ListItem Value="SN">Senegal</asp:ListItem>
                        <asp:ListItem Value="CS">Serbia and Montenegro</asp:ListItem>
                        <asp:ListItem Value="SC">Seychelles</asp:ListItem>
                        <asp:ListItem Value="SL">Sierra Leone</asp:ListItem>
                        <asp:ListItem Value="SG">Singapore</asp:ListItem>
                        <asp:ListItem Value="SK">Slovakia</asp:ListItem>
                        <asp:ListItem Value="SI">Slovenia</asp:ListItem>
                        <asp:ListItem Value="SB">Solomon Islands</asp:ListItem>
                        <asp:ListItem Value="SO">Somalia</asp:ListItem>
                        <asp:ListItem Value="ZA">South Africa</asp:ListItem>
                        <asp:ListItem Value="GS">South Georgia and the South Sandwich Islands</asp:ListItem>
                        <asp:ListItem Value="ES">Spain</asp:ListItem>
                        <asp:ListItem Value="LK">Sri Lanka</asp:ListItem>
                        <asp:ListItem Value="SD">Sudan</asp:ListItem>
                        <asp:ListItem Value="SR">Suriname</asp:ListItem>
                        <asp:ListItem Value="SJ">Svalbard and Jan Mayen</asp:ListItem>
                        <asp:ListItem Value="SZ">Swaziland</asp:ListItem>
                        <asp:ListItem Value="SE">Sweden</asp:ListItem>
                        <asp:ListItem Value="CH">Switzerland</asp:ListItem>
                        <asp:ListItem Value="SY">Syrian Arab Republic</asp:ListItem>
                        <asp:ListItem Value="TW">Taiwan, Province of China</asp:ListItem>
                        <asp:ListItem Value="TJ">Tajikistan</asp:ListItem>
                        <asp:ListItem Value="TZ">Tanzania, United Republic of</asp:ListItem>
                        <asp:ListItem Value="TH">Thailand</asp:ListItem>
                        <asp:ListItem Value="TL">Timor-Leste</asp:ListItem>
                        <asp:ListItem Value="TG">Togo</asp:ListItem>
                        <asp:ListItem Value="TK">Tokelau</asp:ListItem>
                        <asp:ListItem Value="TO">Tonga</asp:ListItem>
                        <asp:ListItem Value="TT">Trinidad and Tobago</asp:ListItem>
                        <asp:ListItem Value="TN">Tunisia</asp:ListItem>
                        <asp:ListItem Value="TR">Turkey</asp:ListItem>
                        <asp:ListItem Value="TM">Turkmenistan</asp:ListItem>
                        <asp:ListItem Value="TC">Turks and Caicos Islands</asp:ListItem>
                        <asp:ListItem Value="TV">Tuvalu</asp:ListItem>
                        <asp:ListItem Value="UG">Uganda</asp:ListItem>
                        <asp:ListItem Value="UA">Ukraine</asp:ListItem>
                        <asp:ListItem Value="AE">United Arab Emirates</asp:ListItem>
                        <asp:ListItem Value="GB">United Kingdom</asp:ListItem>
                        <asp:ListItem Value="US">United States</asp:ListItem>
                        <asp:ListItem Value="UM">United States Minor Outlying Islands</asp:ListItem>
                        <asp:ListItem Value="UY">Uruguay</asp:ListItem>
                        <asp:ListItem Value="UZ">Uzbekistan</asp:ListItem>
                        <asp:ListItem Value="VU">Vanuatu</asp:ListItem>
                        <asp:ListItem Value="VE">Venezuela</asp:ListItem>
                        <asp:ListItem Value="VN">Viet Nam</asp:ListItem>
                        <asp:ListItem Value="VG">Virgin Islands, British</asp:ListItem>
                        <asp:ListItem Value="VI">Virgin Islands, U.s.</asp:ListItem>
                        <asp:ListItem Value="WF">Wallis and Futuna</asp:ListItem>
                        <asp:ListItem Value="EH">Western Sahara</asp:ListItem>
                        <asp:ListItem Value="YE">Yemen</asp:ListItem>
                        <asp:ListItem Value="ZM">Zambia</asp:ListItem>
                        <asp:ListItem Value="ZW">Zimbabwe</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LblTelephone" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtTelephone" Text="Telephone:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtTelephone" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LblFax" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtFax" Text="Fax:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtFax" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LblEmail" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtEmail" Text="Email:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtEmail" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is required"
                        ControlToValidate="TxtEmail" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        ControlToValidate="TxtEmail" ForeColor="Red" ErrorMessage="Invalid Email Format" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            </div>
            </div>

            <div class="modal-header">Shipping Address</div>
            <div class="well">
            <div class="form-group">
                <asp:Label ID="LbldelvName" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtdelvName" Text="Name:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtdelvName" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDelvName" runat="server" ErrorMessage="Delivery name is required"
                        ControlToValidate="TxtdelvName" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LbldelvAddress1" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtdelvAddress1" Text="Address 1:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtdelvAddress1" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvdelvAddress1" runat="server" ErrorMessage="Delivery address 1 is required"
                        ControlToValidate="TxtdelvAddress1" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LbldelvAddress2" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtdelvAddress2" Text="Address 2:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtdelvAddress2" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LbldelvAddress3" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtdelvAddress3" Text="Address 3:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtdelvAddress3" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LbldelvTown" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtdelvTown" Text="Town:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtdelvTown" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDelvTown" runat="server" ErrorMessage="Delivery town is required"
                        ControlToValidate="TxtdelvTown" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LbldelvRegion" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtdelvRegion" Text="Region/County:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtdelvRegion" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LbldelvPostcode" runat="server" CssClass="col-sm-2 control-label" ControlName="TxtdelvPostcode" Text="Postcode:"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox ID="TxtdelvPostcode" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDelvPostcode" runat="server" ErrorMessage="Delivery postcode is required"
                        ControlToValidate="TxtdelvPostcode" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="LbldelvCountry" runat="server" CssClass="col-sm-2 control-label" ControlName="DdldelvCountry" Text="Country:"></asp:Label>
                <div class="col-sm-4">
                    <asp:DropDownList ID="DdldelvCountry" CssClass="form-control" runat="server">
                        <asp:ListItem Value="GB">United Kingdom</asp:ListItem>
                        <asp:ListItem Value="US">United States</asp:ListItem>
                        <asp:ListItem Value="AL">Albania</asp:ListItem>
                        <asp:ListItem Value="DZ">Algeria</asp:ListItem>
                        <asp:ListItem Value="AS">American Samoa</asp:ListItem>
                        <asp:ListItem Value="AD">Andorra</asp:ListItem>
                        <asp:ListItem Value="AO">Angola</asp:ListItem>
                        <asp:ListItem Value="AI">Anguilla</asp:ListItem>
                        <asp:ListItem Value="AQ">Antarctica</asp:ListItem>
                        <asp:ListItem Value="AG">Antigua and Barbuda</asp:ListItem>
                        <asp:ListItem Value="AR">Argentina</asp:ListItem>
                        <asp:ListItem Value="AM">Armenia</asp:ListItem>
                        <asp:ListItem Value="AW">Aruba</asp:ListItem>
                        <asp:ListItem Value="AU">Australia</asp:ListItem>
                        <asp:ListItem Value="AT">Austria</asp:ListItem>
                        <asp:ListItem Value="AZ">Azerbaijan</asp:ListItem>
                        <asp:ListItem Value="BS">Bahamas</asp:ListItem>
                        <asp:ListItem Value="BH">Bahrain</asp:ListItem>
                        <asp:ListItem Value="BD">Bangladesh</asp:ListItem>
                        <asp:ListItem Value="BB">Barbados</asp:ListItem>
                        <asp:ListItem Value="BY">Belarus</asp:ListItem>
                        <asp:ListItem Value="BE">Belgium</asp:ListItem>
                        <asp:ListItem Value="BZ">Belize</asp:ListItem>
                        <asp:ListItem Value="BJ">Benin</asp:ListItem>
                        <asp:ListItem Value="BM">Bermuda</asp:ListItem>
                        <asp:ListItem Value="BT">Bhutan</asp:ListItem>
                        <asp:ListItem Value="BO">Bolivia</asp:ListItem>
                        <asp:ListItem Value="BA">Bosnia and Herzegovina</asp:ListItem>
                        <asp:ListItem Value="BW">Botswana</asp:ListItem>
                        <asp:ListItem Value="BV">Bouvet Island</asp:ListItem>
                        <asp:ListItem Value="BR">Brazil</asp:ListItem>
                        <asp:ListItem Value="IO">British Indian Ocean Territory</asp:ListItem>
                        <asp:ListItem Value="BN">Brunei Darussalam</asp:ListItem>
                        <asp:ListItem Value="BG">Bulgaria</asp:ListItem>
                        <asp:ListItem Value="BF">Burkina Faso</asp:ListItem>
                        <asp:ListItem Value="BI">Burundi</asp:ListItem>
                        <asp:ListItem Value="KH">Cambodia</asp:ListItem>
                        <asp:ListItem Value="CM">Cameroon</asp:ListItem>
                        <asp:ListItem Value="CA">Canada</asp:ListItem>
                        <asp:ListItem Value="CV">Cape Verde</asp:ListItem>
                        <asp:ListItem Value="KY">Cayman Islands</asp:ListItem>
                        <asp:ListItem Value="CF">Central African Republic</asp:ListItem>
                        <asp:ListItem Value="TD">Chad</asp:ListItem>
                        <asp:ListItem Value="CL">Chile</asp:ListItem>
                        <asp:ListItem Value="CN">China</asp:ListItem>
                        <asp:ListItem Value="CX">Christmas Island</asp:ListItem>
                        <asp:ListItem Value="CC">Cocos (Keeling) Islands</asp:ListItem>
                        <asp:ListItem Value="CO">Colombia</asp:ListItem>
                        <asp:ListItem Value="KM">Comoros</asp:ListItem>
                        <asp:ListItem Value="CG">Congo</asp:ListItem>
                        <asp:ListItem Value="CD">Congo, the Democratic Republic of the</asp:ListItem>
                        <asp:ListItem Value="CK">Cook Islands</asp:ListItem>
                        <asp:ListItem Value="CR">Costa Rica</asp:ListItem>
                        <asp:ListItem Value="CI">Cote D'Ivoire</asp:ListItem>
                        <asp:ListItem Value="HR">Croatia</asp:ListItem>
                        <asp:ListItem Value="CU">Cuba</asp:ListItem>
                        <asp:ListItem Value="CY">Cyprus</asp:ListItem>
                        <asp:ListItem Value="CZ">Czech Republic</asp:ListItem>
                        <asp:ListItem Value="DK">Denmark</asp:ListItem>
                        <asp:ListItem Value="DJ">Djibouti</asp:ListItem>
                        <asp:ListItem Value="DM">Dominica</asp:ListItem>
                        <asp:ListItem Value="DO">Dominican Republic</asp:ListItem>
                        <asp:ListItem Value="EC">Ecuador</asp:ListItem>
                        <asp:ListItem Value="EG">Egypt</asp:ListItem>
                        <asp:ListItem Value="SV">El Salvador</asp:ListItem>
                        <asp:ListItem Value="GQ">Equatorial Guinea</asp:ListItem>
                        <asp:ListItem Value="ER">Eritrea</asp:ListItem>
                        <asp:ListItem Value="EE">Estonia</asp:ListItem>
                        <asp:ListItem Value="ET">Ethiopia</asp:ListItem>
                        <asp:ListItem Value="FK">Falkland Islands (Malvinas)</asp:ListItem>
                        <asp:ListItem Value="FO">Faroe Islands</asp:ListItem>
                        <asp:ListItem Value="FJ">Fiji</asp:ListItem>
                        <asp:ListItem Value="FI">Finland</asp:ListItem>
                        <asp:ListItem Value="FR">France</asp:ListItem>
                        <asp:ListItem Value="GF">French Guiana</asp:ListItem>
                        <asp:ListItem Value="PF">French Polynesia</asp:ListItem>
                        <asp:ListItem Value="TF">French Southern Territories</asp:ListItem>
                        <asp:ListItem Value="GA">Gabon</asp:ListItem>
                        <asp:ListItem Value="GM">Gambia</asp:ListItem>
                        <asp:ListItem Value="GE">Georgia</asp:ListItem>
                        <asp:ListItem Value="DE">Germany</asp:ListItem>
                        <asp:ListItem Value="GH">Ghana</asp:ListItem>
                        <asp:ListItem Value="GI">Gibraltar</asp:ListItem>
                        <asp:ListItem Value="GR">Greece</asp:ListItem>
                        <asp:ListItem Value="GL">Greenland</asp:ListItem>
                        <asp:ListItem Value="GD">Grenada</asp:ListItem>
                        <asp:ListItem Value="GP">Guadeloupe</asp:ListItem>
                        <asp:ListItem Value="GU">Guam</asp:ListItem>
                        <asp:ListItem Value="GT">Guatemala</asp:ListItem>
                        <asp:ListItem Value="GN">Guinea</asp:ListItem>
                        <asp:ListItem Value="GW">Guinea-Bissau</asp:ListItem>
                        <asp:ListItem Value="GY">Guyana</asp:ListItem>
                        <asp:ListItem Value="HT">Haiti</asp:ListItem>
                        <asp:ListItem Value="HM">Heard Island and Mcdonald Islands</asp:ListItem>
                        <asp:ListItem Value="VA">Holy See (Vatican City State)</asp:ListItem>
                        <asp:ListItem Value="HN">Honduras</asp:ListItem>
                        <asp:ListItem Value="HK">Hong Kong</asp:ListItem>
                        <asp:ListItem Value="HU">Hungary</asp:ListItem>
                        <asp:ListItem Value="IS">Iceland</asp:ListItem>
                        <asp:ListItem Value="IN">India</asp:ListItem>
                        <asp:ListItem Value="ID">Indonesia</asp:ListItem>
                        <asp:ListItem Value="IR">Iran, Islamic Republic of</asp:ListItem>
                        <asp:ListItem Value="IQ">Iraq</asp:ListItem>
                        <asp:ListItem Value="IE">Ireland</asp:ListItem>
                        <asp:ListItem Value="IL">Israel</asp:ListItem>
                        <asp:ListItem Value="IT">Italy</asp:ListItem>
                        <asp:ListItem Value="JM">Jamaica</asp:ListItem>
                        <asp:ListItem Value="JP">Japan</asp:ListItem>
                        <asp:ListItem Value="JO">Jordan</asp:ListItem>
                        <asp:ListItem Value="KZ">Kazakhstan</asp:ListItem>
                        <asp:ListItem Value="KE">Kenya</asp:ListItem>
                        <asp:ListItem Value="KI">Kiribati</asp:ListItem>
                        <asp:ListItem Value="KP">Korea, Democratic People's Republic of</asp:ListItem>
                        <asp:ListItem Value="KR">Korea, Republic of</asp:ListItem>
                        <asp:ListItem Value="KW">Kuwait</asp:ListItem>
                        <asp:ListItem Value="KG">Kyrgyzstan</asp:ListItem>
                        <asp:ListItem Value="LA">Lao People's Democratic Republic</asp:ListItem>
                        <asp:ListItem Value="LV">Latvia</asp:ListItem>
                        <asp:ListItem Value="LB">Lebanon</asp:ListItem>
                        <asp:ListItem Value="LS">Lesotho</asp:ListItem>
                        <asp:ListItem Value="LR">Liberia</asp:ListItem>
                        <asp:ListItem Value="LY">Libyan Arab Jamahiriya</asp:ListItem>
                        <asp:ListItem Value="LI">Liechtenstein</asp:ListItem>
                        <asp:ListItem Value="LT">Lithuania</asp:ListItem>
                        <asp:ListItem Value="LU">Luxembourg</asp:ListItem>
                        <asp:ListItem Value="MO">Macao</asp:ListItem>
                        <asp:ListItem Value="MK">Macedonia, the Former Yugoslav Republic of</asp:ListItem>
                        <asp:ListItem Value="MG">Madagascar</asp:ListItem>
                        <asp:ListItem Value="MW">Malawi</asp:ListItem>
                        <asp:ListItem Value="MY">Malaysia</asp:ListItem>
                        <asp:ListItem Value="MV">Maldives</asp:ListItem>
                        <asp:ListItem Value="ML">Mali</asp:ListItem>
                        <asp:ListItem Value="MT">Malta</asp:ListItem>
                        <asp:ListItem Value="MH">Marshall Islands</asp:ListItem>
                        <asp:ListItem Value="MQ">Martinique</asp:ListItem>
                        <asp:ListItem Value="MR">Mauritania</asp:ListItem>
                        <asp:ListItem Value="MU">Mauritius</asp:ListItem>
                        <asp:ListItem Value="YT">Mayotte</asp:ListItem>
                        <asp:ListItem Value="MX">Mexico</asp:ListItem>
                        <asp:ListItem Value="FM">Micronesia, Federated States of</asp:ListItem>
                        <asp:ListItem Value="MD">Moldova, Republic of</asp:ListItem>
                        <asp:ListItem Value="MC">Monaco</asp:ListItem>
                        <asp:ListItem Value="MN">Mongolia</asp:ListItem>
                        <asp:ListItem Value="MS">Montserrat</asp:ListItem>
                        <asp:ListItem Value="MA">Morocco</asp:ListItem>
                        <asp:ListItem Value="MZ">Mozambique</asp:ListItem>
                        <asp:ListItem Value="MM">Myanmar</asp:ListItem>
                        <asp:ListItem Value="NA">Namibia</asp:ListItem>
                        <asp:ListItem Value="NR">Nauru</asp:ListItem>
                        <asp:ListItem Value="NP">Nepal</asp:ListItem>
                        <asp:ListItem Value="NL">Netherlands</asp:ListItem>
                        <asp:ListItem Value="AN">Netherlands Antilles</asp:ListItem>
                        <asp:ListItem Value="NC">New Caledonia</asp:ListItem>
                        <asp:ListItem Value="NZ">New Zealand</asp:ListItem>
                        <asp:ListItem Value="NI">Nicaragua</asp:ListItem>
                        <asp:ListItem Value="NE">Niger</asp:ListItem>
                        <asp:ListItem Value="NG">Nigeria</asp:ListItem>
                        <asp:ListItem Value="NU">Niue</asp:ListItem>
                        <asp:ListItem Value="NF">Norfolk Island</asp:ListItem>
                        <asp:ListItem Value="MP">Northern Mariana Islands</asp:ListItem>
                        <asp:ListItem Value="NO">Norway</asp:ListItem>
                        <asp:ListItem Value="OM">Oman</asp:ListItem>
                        <asp:ListItem Value="PK">Pakistan</asp:ListItem>
                        <asp:ListItem Value="PW">Palau</asp:ListItem>
                        <asp:ListItem Value="PS">Palestinian Territory, Occupied</asp:ListItem>
                        <asp:ListItem Value="PA">Panama</asp:ListItem>
                        <asp:ListItem Value="PG">Papua New Guinea</asp:ListItem>
                        <asp:ListItem Value="PY">Paraguay</asp:ListItem>
                        <asp:ListItem Value="PE">Peru</asp:ListItem>
                        <asp:ListItem Value="PH">Philippines</asp:ListItem>
                        <asp:ListItem Value="PN">Pitcairn</asp:ListItem>
                        <asp:ListItem Value="PL">Poland</asp:ListItem>
                        <asp:ListItem Value="PT">Portugal</asp:ListItem>
                        <asp:ListItem Value="PR">Puerto Rico</asp:ListItem>
                        <asp:ListItem Value="QA">Qatar</asp:ListItem>
                        <asp:ListItem Value="RE">Reunion</asp:ListItem>
                        <asp:ListItem Value="RO">Romania</asp:ListItem>
                        <asp:ListItem Value="RU">Russian Federation</asp:ListItem>
                        <asp:ListItem Value="RW">Rwanda</asp:ListItem>
                        <asp:ListItem Value="SH">Saint Helena</asp:ListItem>
                        <asp:ListItem Value="KN">Saint Kitts and Nevis</asp:ListItem>
                        <asp:ListItem Value="LC">Saint Lucia</asp:ListItem>
                        <asp:ListItem Value="PM">Saint Pierre and Miquelon</asp:ListItem>
                        <asp:ListItem Value="VC">Saint Vincent and the Grenadines</asp:ListItem>
                        <asp:ListItem Value="WS">Samoa</asp:ListItem>
                        <asp:ListItem Value="SM">San Marino</asp:ListItem>
                        <asp:ListItem Value="ST">Sao Tome and Principe</asp:ListItem>
                        <asp:ListItem Value="SA">Saudi Arabia</asp:ListItem>
                        <asp:ListItem Value="SN">Senegal</asp:ListItem>
                        <asp:ListItem Value="CS">Serbia and Montenegro</asp:ListItem>
                        <asp:ListItem Value="SC">Seychelles</asp:ListItem>
                        <asp:ListItem Value="SL">Sierra Leone</asp:ListItem>
                        <asp:ListItem Value="SG">Singapore</asp:ListItem>
                        <asp:ListItem Value="SK">Slovakia</asp:ListItem>
                        <asp:ListItem Value="SI">Slovenia</asp:ListItem>
                        <asp:ListItem Value="SB">Solomon Islands</asp:ListItem>
                        <asp:ListItem Value="SO">Somalia</asp:ListItem>
                        <asp:ListItem Value="ZA">South Africa</asp:ListItem>
                        <asp:ListItem Value="GS">South Georgia and the South Sandwich Islands</asp:ListItem>
                        <asp:ListItem Value="ES">Spain</asp:ListItem>
                        <asp:ListItem Value="LK">Sri Lanka</asp:ListItem>
                        <asp:ListItem Value="SD">Sudan</asp:ListItem>
                        <asp:ListItem Value="SR">Suriname</asp:ListItem>
                        <asp:ListItem Value="SJ">Svalbard and Jan Mayen</asp:ListItem>
                        <asp:ListItem Value="SZ">Swaziland</asp:ListItem>
                        <asp:ListItem Value="SE">Sweden</asp:ListItem>
                        <asp:ListItem Value="CH">Switzerland</asp:ListItem>
                        <asp:ListItem Value="SY">Syrian Arab Republic</asp:ListItem>
                        <asp:ListItem Value="TW">Taiwan, Province of China</asp:ListItem>
                        <asp:ListItem Value="TJ">Tajikistan</asp:ListItem>
                        <asp:ListItem Value="TZ">Tanzania, United Republic of</asp:ListItem>
                        <asp:ListItem Value="TH">Thailand</asp:ListItem>
                        <asp:ListItem Value="TL">Timor-Leste</asp:ListItem>
                        <asp:ListItem Value="TG">Togo</asp:ListItem>
                        <asp:ListItem Value="TK">Tokelau</asp:ListItem>
                        <asp:ListItem Value="TO">Tonga</asp:ListItem>
                        <asp:ListItem Value="TT">Trinidad and Tobago</asp:ListItem>
                        <asp:ListItem Value="TN">Tunisia</asp:ListItem>
                        <asp:ListItem Value="TR">Turkey</asp:ListItem>
                        <asp:ListItem Value="TM">Turkmenistan</asp:ListItem>
                        <asp:ListItem Value="TC">Turks and Caicos Islands</asp:ListItem>
                        <asp:ListItem Value="TV">Tuvalu</asp:ListItem>
                        <asp:ListItem Value="UG">Uganda</asp:ListItem>
                        <asp:ListItem Value="UA">Ukraine</asp:ListItem>
                        <asp:ListItem Value="AE">United Arab Emirates</asp:ListItem>
                        <asp:ListItem Value="GB">United Kingdom</asp:ListItem>
                        <asp:ListItem Value="US">United States</asp:ListItem>
                        <asp:ListItem Value="UM">United States Minor Outlying Islands</asp:ListItem>
                        <asp:ListItem Value="UY">Uruguay</asp:ListItem>
                        <asp:ListItem Value="UZ">Uzbekistan</asp:ListItem>
                        <asp:ListItem Value="VU">Vanuatu</asp:ListItem>
                        <asp:ListItem Value="VE">Venezuela</asp:ListItem>
                        <asp:ListItem Value="VN">Viet Nam</asp:ListItem>
                        <asp:ListItem Value="VG">Virgin Islands, British</asp:ListItem>
                        <asp:ListItem Value="VI">Virgin Islands, U.s.</asp:ListItem>
                        <asp:ListItem Value="WF">Wallis and Futuna</asp:ListItem>
                        <asp:ListItem Value="EH">Western Sahara</asp:ListItem>
                        <asp:ListItem Value="YE">Yemen</asp:ListItem>
                        <asp:ListItem Value="ZM">Zambia</asp:ListItem>
                        <asp:ListItem Value="ZW">Zimbabwe</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <asp:Button ID="BtnProcessTransaction" runat="server" CssClass="btn btn-primary" Text="Process Payment" OnClick="ProcessTransaction_Click" />
            </div>
        </div>
    </div>
    </form>
</asp:Content>
