<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "title">
        ${msg("registerWithTitle",(realm.displayName!''))}
    <#elseif section = "header">
        ${msg("registerWithTitleHtml",(realm.displayNameHtml!''))}
    <#elseif section = "form">
        <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
          <input type="text" readonly value="this is not a login form" style="display: none;">
          <input type="password" readonly value="this is not a login form" style="display: none;">
    


          <div class="${properties.kcFormGroupClass!}" data-toggle="buttons">
            You are
            <label class="active">
              <input type="radio" name="user.attributes.gender" id="user.attributes.gender" value="male" autocomplete="off" checked>
              Male
            </label>
            <label>
              <input type="radio" name="user.attributes.gender" id="user.attributes.gender" value="female" autocomplete="off">
              Female
            </label>
          </div>

          <#if !realm.registrationEmailAsUsername>
            <div class="${properties.kcFormGroupClass!}">
            <span class="input-group-addon"><div class="fa fa-user"></div></span>
            <input type="text" id="username" name="username" class="form-control" placeholder="${msg("username")}">
            </div>
          </#if>

            <div class="${properties.kcFormGroupClass!}">
            <span class="input-group-addon"><div class="fa fa-user"></div></span>
            <input type="text" id="firstName" name="firstName" class="form-control" placeholder="${msg("firstName")}">
            </div>

            <div class="${properties.kcFormGroupClass!}">
            <span class="input-group-addon"><div class="fa fa-user"></div></span>
            <input type="text" id="lastName" name="lastName" class="form-control" placeholder="${msg("lastName")}">
            </div>

            <div class="${properties.kcFormGroupClass!}">
            <span class="input-group-addon"><div class="fa fa-envelope"></div></span>
            <input type="text" id="email" name="email" class="form-control" placeholder="${msg("email")}">
            </div>

            <#if passwordRequired>
            <div class="${properties.kcFormGroupClass!}">
            <span class="input-group-addon"><div class="fa fa-lock"></div></span>
            <input type="password" id="password" name="password" class="form-control" placeholder="${msg("password")}">
            </div>

            <div class="${properties.kcFormGroupClass!}">
            <span class="input-group-addon"><div class="fa fa-lock"></div></span>
            <input type="password" id="password-confirm" name="password-confirm" class="form-control" placeholder="${msg("passwordConfirm")}">
            </div>
            </#if>

            <#if recaptchaRequired??>
            <div class="form-group">
                <div class="${properties.kcInputWrapperClass!}">
                    <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                </div>
            </div>
            </#if>

            <div>${msg("acceptTC")}</div>

            <input class="${properties.kcFormButtonsClass!} ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doRegister")}"/>

        </form>
    </#if>
</@layout.registrationLayout>
